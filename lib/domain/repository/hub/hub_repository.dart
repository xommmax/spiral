import 'dart:async';

import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';

abstract class HubRepository {
  Future<Hub> createHub({
    required String name,
    required String description,
    required MediaFile picture,
    required bool isPrivate,
  });

  Stream<List<Hub>> getCurrentUserHubs();

  Stream<List<Hub>> getHubs(String userId);

  Stream<List<Hub>> getHubsByIds(List<String> hubIds);

  Stream<Hub> getHub(String hubId);

  Stream<Hub> getOnboardingHub();

  Future<void> onFollow(String hubId);

  Future<void> onUnfollow(String hubId);

  Future<List<String>> getHubFollowersIds(String hubId);

  Future<List<String>> getUserFollowsHubsIds(String userId);
}
