import 'dart:async';

import 'package:dairo/domain/model/hub/discussion.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';

abstract class HubRepository {
  Future<Hub> createHub({
    required String name,
    required String? description,
    required String? pictureUrl,
    required bool isPrivate,
    required bool isDiscussionEnabled,
  });

  Future<String> uploadHubPicture(LocalMediaFile hubPicture);

  Stream<List<Hub>> getCurrentUserHubs();

  Stream<List<Hub>> getHubs(String userId);

  Stream<List<Hub>> getHubsByIds(List<String> hubIds);

  Future<List<String>> getUserFollowingHubIds(String userId);

  Stream<Hub> getHub(String hubId);

  Stream<Hub> getOnboardingHub();

  Future<void> onFollow(String hubId);

  Future<void> onUnfollow(String hubId);

  Future<List<String>> getHubFollowersIds(String hubId);

  Future<Hub> setHubPrivate(Hub hub, bool private);

  Future<void> deleteHub(Hub hub);

  Future<HubDiscussion> getHubDiscussion(String hubId);

  Future<void> reorderHubs(List<Hub> hubs);

  Future<void> updateHub(
      String hubId, String name, String description, String? newPictureUrl);
}
