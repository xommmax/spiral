import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firestore_keys.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/hub_remote_repository.dart';
import 'package:dairo/data/api/repository/publication_remote_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExploreRemoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PublicationRemoteRepository _publicationRemoteRepository =
      locator<PublicationRemoteRepository>();
  final HubRemoteRepository _hubRemoteRepository =
      locator<HubRemoteRepository>();

  Future<List<UserResponse>> searchProfiles(String searchQuery) => _firestore
      .collection(FirebaseCollections.users)
      .where(FirestoreKeys.name,
          isGreaterThanOrEqualTo: searchQuery,
          isLessThanOrEqualTo: searchQuery + '\uf8ff')
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => UserResponse.fromJson(doc.data(), id: doc.id))
          .toList());

  Future<List<HubResponse>> searchHubs(String searchQuery) => _firestore
      .collection(FirebaseCollections.userHubs)
      .where(FirestoreKeys.isPrivate, isEqualTo: false)
      .where(FirestoreKeys.name,
          isGreaterThanOrEqualTo: searchQuery,
          isLessThanOrEqualTo: searchQuery + '\uf8ff')
      .get()
      .then(
        (snapshot) => Future.wait(
          snapshot.docs.map(
            (doc) async => HubResponse.fromJson(
              doc.data(),
              id: doc.id,
              isFollow: await _hubRemoteRepository.isCurrentUserFollows(doc.id),
            ),
          ),
        ),
      );

  Future<List<PublicationResponse>> fetchExplorePublications() => _firestore
      .collection(FirebaseCollections.hubPublications)
      .orderBy(FirestoreKeys.createdAt, descending: true)
      .get()
      .then(
        (snapshot) => Future.wait(
          snapshot.docs.map(
            (doc) async => PublicationResponse.fromJson(
              doc.data(),
              id: doc.id,
              isLiked:
                  await _publicationRemoteRepository.isCurrentUserLiked(doc.id),
            ),
          ),
        ),
      );

  Future<List<HubResponse>> fetchExploreHubs() => _firestore
      .collection(FirebaseCollections.userHubs)
      .where('isPrivate', isEqualTo: false)
      .orderBy(FirestoreKeys.createdAt, descending: true)
      .limit(3)
      .get()
      .then(
        (snapshot) => Future.wait(
          snapshot.docs.map(
            (doc) async => HubResponse.fromJson(
              doc.data(),
              id: doc.id,
              isFollow: await _hubRemoteRepository.isCurrentUserFollows(doc.id),
            ),
          ),
        ),
      );

  Future<List<String>> getExploreHubMediaPreviews(String hubId) async {
    final snapshot = await _firestore
        .collection(FirebaseCollections.hubPublications)
        .where(FirestoreKeys.hubId, isEqualTo: hubId)
        .orderBy(FirestoreKeys.createdAt, descending: true)
        .limit(3)
        .get();

    List<String> urls = [];
    snapshot.docs
        .map((doc) => PublicationResponse.fromJson(
              doc.data(),
              id: doc.id,
              isLiked: false,
            ))
        .forEach((response) {
      if (response.previewUrls.isNotEmpty) urls.add(response.previewUrls[0]);
    });
    return urls;
  }
}
