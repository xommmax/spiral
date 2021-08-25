import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:dairo/data/api/firestore_keys.dart';
import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

import 'firebase_storage_repository.dart';

@lazySingleton
class HubRemoteRepository {
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepository _userRepository = locator<UserRepository>();

  Future<HubResponse> createHub(HubRequest hubRequest, File hubPicture) async {
    List<String> uploadedUrls = await _firebaseStorageRepository
        .uploadMultipleFiles([hubPicture], FirebaseStorageFolders.hubPictures);
    hubRequest.pictureUrl = uploadedUrls[0];

    final snapshot = await _firestore
        .collection(FirebaseCollections.userHubs)
        .add(hubRequest.toJson())
        .then((reference) => reference.get());

    return HubResponse.fromJson(
      snapshot.data(),
      id: snapshot.id,
      isFollow: false,
    );
  }

  Future<List<HubResponse>> fetchUserHubs(String userId) => _firestore
      .collection(FirebaseCollections.userHubs)
      .where(FirestoreKeys.userId, isEqualTo: userId)
      .get()
      .then(
        (snapshot) => Future.wait(
          snapshot.docs.map(
            (doc) async => HubResponse.fromJson(
              doc.data(),
              id: doc.id,
              isFollow: await isCurrentUserFollows(doc.id),
            ),
          ),
        ),
      );

  Future<HubResponse> fetchHub(String hubId) =>
      _firestore.doc('${FirebaseCollections.userHubs}/$hubId').get().then(
            (doc) async => HubResponse.fromJson(
              doc.data(),
              id: doc.id,
              isFollow: await isCurrentUserFollows(doc.id),
            ),
          );

  Future<bool> isCurrentUserFollows(String hubId) => _firestore
      .doc(
          '${FirebaseCollections.usersFollowHubs}/${_userRepository.checkAndGetCurrentUserId()}/${FirestoreKeys.hubs}/$hubId')
      .get()
      .then((snapshot) => snapshot.exists);

  Future<HubResponse> follow({
    required String hubId,
    required String userId,
  }) =>
      Future.wait([
        _firestore
            .collection(
                '${FirebaseCollections.hubsFollowers}/$hubId/${FirestoreKeys.users}')
            .doc(userId)
            .set({}),
        _firestore
            .collection(
                '${FirebaseCollections.usersFollowHubs}/$userId/${FirestoreKeys.hubs}')
            .doc(hubId)
            .set({}),
      ]).then(
        (_) => fetchHub(hubId),
      );

  Future<HubResponse> unfollow({
    required String hubId,
    required String userId,
  }) =>
      Future.wait([
        _firestore
            .collection(
                '${FirebaseCollections.hubsFollowers}/$hubId/${FirestoreKeys.users}')
            .doc(userId)
            .delete(),
        _firestore
            .collection(
                '${FirebaseCollections.usersFollowHubs}/$userId/${FirestoreKeys.hubs}')
            .doc(hubId)
            .delete(),
      ]).then(
        (_) => fetchHub(hubId),
      );

  Future<List<String>> fetchHubFollowers(String hubId) => _firestore
      .collection(
          '${FirebaseCollections.hubsFollowers}/$hubId/${FirebaseCollections.users}')
      .get()
      .then((result) => result.docs.map((doc) => doc.id).toList());
}
