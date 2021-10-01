import 'dart:async';
import 'dart:io';

import 'package:dairo/app/analytics.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_documents.dart';
import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/data/api/repository/hub_remote_repository.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:dairo/data/db/repository/hub_local_repository.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HubRepository)
class HubRepositoryImpl implements HubRepository {
  final HubLocalRepository _local = locator<HubLocalRepository>();
  final HubRemoteRepository _remote = locator<HubRemoteRepository>();
  final UserRepository _userRepository = locator<UserRepository>();
  final AnalyticsRepository _analyticsRepository =
      locator<AnalyticsRepository>();

  @override
  Future<Hub> createHub({
    required String name,
    required String description,
    required LocalMediaFile picture,
    required bool isPrivate,
  }) async {
    final currentUserId = _userRepository.getCurrentUserId();
    HubRequest request = HubRequest(
      userId: currentUserId,
      name: name,
      description: description,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      isPrivate: isPrivate,
    );

    HubResponse response =
        await _remote.createHub(request, File(picture.previewImage.path));
    HubItemData itemData = HubItemData.fromResponse(response);
    await _local.addHub(itemData);
    final hub = Hub.fromItemData(itemData);
    _sendHubCreatedEvent(hub);
    return hub;
  }

  Stream<List<Hub>> getCurrentUserHubs() =>
      getHubs(_userRepository.getCurrentUserId());

  Stream<List<Hub>> getHubs(String userId) {
    Stream<List<Hub>> stream = _local
        .getHubs(userId)
        .map((itemData) => itemData.map((e) => Hub.fromItemData(e)).toList());

    _remote.fetchHubs(userId).then((response) {
      final itemDataList =
          response.map((e) => HubItemData.fromResponse(e)).toList();
      _local.updateHubs(itemDataList, userId);
    });
    return stream;
  }

  @override
  Stream<Hub> getHub(String hubId) {
    _remote.fetchHubStream(hubId).listen(
          (futureHub) => futureHub.then(
            (response) => _local.updateHub(
              HubItemData.fromResponse(response),
            ),
          ),
        );

    return _local.getHub(hubId).where((value) => value != null).map(
          (itemData) => Hub.fromItemData(itemData!),
        );
  }

  @override
  Stream<Hub> getOnboardingHub() {
    _remote.fetchOnboardingHub().then(
          (response) => _local.updateHub(
            HubItemData.fromResponse(response),
          ),
        );

    return _local.getHub(FirebaseDocuments.onboardingHub).map(
          (itemData) => Hub.fromItemData(itemData!),
        );
  }

  @override
  Future<void> onFollow(String hubId) => _remote.onFollow(
        userId: _userRepository.getCurrentUserId(),
        hubId: hubId,
      );

  @override
  Future<void> onUnfollow(String hubId) => _remote.onUnfollow(
        userId: _userRepository.getCurrentUserId(),
        hubId: hubId,
      );

  @override
  Future<List<String>> getHubFollowersIds(String hubId) =>
      _remote.fetchHubFollowersIds(hubId);

  @override
  Future<List<String>> getUserFollowsHubsIds(String userId) =>
      _remote.fetchUserFollowsHubsIds(userId);

  @override
  Stream<List<Hub>> getHubsByIds(List<String> hubIds) {
    Stream<List<Hub>> stream = _local
        .getHubsByIds(hubIds)
        .map((itemData) => itemData.map((e) => Hub.fromItemData(e)).toList());

    _remote.fetchHubsByIds(hubIds).then((response) {
      final itemData =
          response.map((e) => HubItemData.fromResponse(e)).toList();
      _local.addHubs(itemData);
    });
    return stream;
  }

  Future<void> _sendHubCreatedEvent(Hub hub) => _analyticsRepository.logEvent(
        name: AnalyticsEventKeys.userCreatedHub,
        parameters: {
          AnalyticsEventPropertiesKeys.userId: hub.userId,
          AnalyticsEventPropertiesKeys.hubId: hub.id,
        },
      );

  @override
  Future<Hub> setHubPrivate(Hub hub, bool private) async =>
      _remote.setHubPrivate(hub, private).then((response) async {
        await _local.updateHub(HubItemData.fromResponse(response));
        HubItemData itemData = (await _local.getHub(hub.id).first)!;
        return Hub.fromItemData(itemData);
      });

  @override
  Future<void> deleteHub(Hub hub) => _remote.deleteHub(hub).then((response) {
        return _local.deleteHub(HubItemData.fromResponse(response));
      });
}
