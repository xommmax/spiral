import 'dart:async';
import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/data/api/repository/hub_remote_repository.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:dairo/data/db/repository/hub_local_repository.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HubRepository)
class HubRepositoryImpl implements HubRepository {
  final HubLocalRepository _local = locator<HubLocalRepository>();
  final HubRemoteRepository _remote = locator<HubRemoteRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  Future<void> createHub({
    required String name,
    required String description,
    required MediaFile picture,
  }) async {
    final currentUserId = _userRepository.checkAndGetCurrentUserId();
    HubRequest request = HubRequest(
      userId: currentUserId,
      name: name,
      description: description,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    HubResponse response = await _remote.createHub(request, File(picture.path));
    await _local.addHub(HubItemData.fromResponse(response));
  }

  Stream<List<Hub>> getCurrentUserHubs() =>
      getUserHubs(_userRepository.checkAndGetCurrentUserId());

  Stream<List<Hub>> getUserHubs(String userId) {
    Stream<List<Hub>> stream = _local
        .getHubs(userId)
        .map((itemData) => itemData.map((e) => Hub.fromItemData(e)).toList());

    _remote.fetchUserHubs(userId).then((response) {
      final itemData =
          response.map((e) => HubItemData.fromResponse(e)).toList();
      _local.addHubs(itemData);
    });
    return stream;
  }

  @override
  Stream<Hub> getHub(String hubId) {
    Stream<Hub> stream = _local.getHub(hubId).map(
          (itemData) => Hub.fromItemData(itemData!),
        );

    _remote.fetchHub(hubId).then(
          (response) => _local.updateHub(
            HubItemData.fromResponse(response),
          ),
        );
    return stream;
  }

  @override
  Future<void> follow(String hubId) => _remote
      .follow(
        userId: _userRepository.checkAndGetCurrentUserId(),
        hubId: hubId,
      )
      .then(
        (response) => _local.updateHub(
          HubItemData.fromResponse(response),
        ),
      );

  @override
  Future<void> unfollow(String hubId) => _remote
      .unfollow(
        userId: _userRepository.checkAndGetCurrentUserId(),
        hubId: hubId,
      )
      .then(
        (response) => _local.updateHub(
          HubItemData.fromResponse(response),
        ),
      );

  @override
  Future<List<String>> getHubFollowers(String hubId) =>
      _remote.fetchHubFollowers(hubId);
}
