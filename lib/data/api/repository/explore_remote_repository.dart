import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firestore_keys.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/hub_remote_repository.dart';
import 'package:dairo/data/api/repository/publication_remote_repository.dart';
import 'package:dairo/presentation/view/tools/string_tools.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExploreRemoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PublicationRemoteRepository _publicationRemoteRepository =
      locator<PublicationRemoteRepository>();
  final HubRemoteRepository _hubRemoteRepository =
      locator<HubRemoteRepository>();

  Future<List<UserResponse>> searchProfiles(String searchQuery) async {
    List<UserResponse> result = [];
    final nameMatchCase = await _firestore
        .collection(FirebaseCollections.users)
        .where(FirestoreKeys.name,
            isGreaterThanOrEqualTo: searchQuery,
            isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => UserResponse.fromJson(doc.data(), id: doc.id))
            .toList());

    final nameCapitalize = await _firestore
        .collection(FirebaseCollections.users)
        .where(FirestoreKeys.name,
            isGreaterThanOrEqualTo: searchQuery.capitalize(),
            isLessThanOrEqualTo: searchQuery.capitalize() + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => UserResponse.fromJson(doc.data(), id: doc.id))
            .toList());

    final descMatchCase = await _firestore
        .collection(FirebaseCollections.users)
        .where(FirestoreKeys.description,
            isGreaterThanOrEqualTo: searchQuery,
            isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => UserResponse.fromJson(doc.data(), id: doc.id))
            .toList());

    final descCapitalize = await _firestore
        .collection(FirebaseCollections.users)
        .where(FirestoreKeys.description,
            isGreaterThanOrEqualTo: searchQuery.capitalize(),
            isLessThanOrEqualTo: searchQuery.capitalize() + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => UserResponse.fromJson(doc.data(), id: doc.id))
            .toList());

    result.addAll(nameMatchCase);
    result.addAll(nameCapitalize);
    result.addAll(descMatchCase);
    result.addAll(descCapitalize);

    return result;
  }

  Future<List<HubResponse>> searchHubs(String searchQuery) async {
    List<HubResponse> result = [];
    final nameMatchCase = await _firestore
        .collection(FirebaseCollections.userHubs)
        .where(FirestoreKeys.isPrivate, isEqualTo: false)
        .where(FirestoreKeys.name,
            isGreaterThanOrEqualTo: searchQuery,
            isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) =>
                HubResponse.fromJson(doc.data(), id: doc.id, isFollow: false))
            .toList());

    final nameCapitalize = await _firestore
        .collection(FirebaseCollections.userHubs)
        .where(FirestoreKeys.isPrivate, isEqualTo: false)
        .where(FirestoreKeys.name,
            isGreaterThanOrEqualTo: searchQuery.capitalize(),
            isLessThanOrEqualTo: searchQuery.capitalize() + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) =>
                HubResponse.fromJson(doc.data(), id: doc.id, isFollow: false))
            .toList());

    final descMatchCase = await _firestore
        .collection(FirebaseCollections.userHubs)
        .where(FirestoreKeys.isPrivate, isEqualTo: false)
        .where(FirestoreKeys.description,
            isGreaterThanOrEqualTo: searchQuery,
            isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) =>
                HubResponse.fromJson(doc.data(), id: doc.id, isFollow: false))
            .toList());

    final descCapitalize = await _firestore
        .collection(FirebaseCollections.userHubs)
        .where(FirestoreKeys.isPrivate, isEqualTo: false)
        .where(FirestoreKeys.description,
            isGreaterThanOrEqualTo: searchQuery.capitalize(),
            isLessThanOrEqualTo: searchQuery.capitalize() + '\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) =>
                HubResponse.fromJson(doc.data(), id: doc.id, isFollow: false))
            .toList());

    result.addAll(nameMatchCase);
    result.addAll(nameCapitalize);
    result.addAll(descMatchCase);
    result.addAll(descCapitalize);

    return result;
  }

  Future<List<PublicationResponse>> fetchExplorePublications() async {
    final querySnapshot = await _firestore
        .collection(FirebaseCollections.explorePublications)
        .orderBy(FirestoreKeys.createdAt, descending: true)
        .get();

    Map<String, int> customCreatedAt = {};
    List<PublicationResponse> responses =
        await Future.wait(querySnapshot.docs.map((snap) {
      customCreatedAt[snap.id] = snap.data()[FirestoreKeys.createdAt];
      return _publicationRemoteRepository.fetchPublication(snap.id);
    }));
    responses.sort((p1, p2) =>
        (customCreatedAt[p2.id] ?? p2.createdAt) -
        (customCreatedAt[p1.id] ?? p1.createdAt));
    return responses;
  }

  Future<List<PublicationResponse>> fetchRecentPublications() async {
    final querySnapshot = await _firestore
        .collection(FirebaseCollections.hubPublications)
        .orderBy(FirestoreKeys.createdAt, descending: true)
        .limit(18)
        .get();

    List<PublicationResponse> responses = await Future.wait(querySnapshot.docs
        .map((snap) => _publicationRemoteRepository.fetchPublication(snap.id)));
    responses.sort((p1, p2) => p2.createdAt - p1.createdAt);
    return responses;
  }

  Future<List<HubResponse>> fetchExploreHubs() async {
    final querySnapshot = await _firestore
        .collection(FirebaseCollections.exploreHubs)
        .orderBy(FirestoreKeys.createdAt, descending: true)
        .get();

    Map<String, int> customCreatedAt = {};

    List<HubResponse> responses =
        await Future.wait(querySnapshot.docs.map((snap) {
      customCreatedAt[snap.id] = snap.data()[FirestoreKeys.createdAt];
      return _hubRemoteRepository.fetchHub(snap.id);
    }));
    responses.sort((p1, p2) =>
        (customCreatedAt[p2.id] ?? p2.createdAt) -
        (customCreatedAt[p1.id] ?? p1.createdAt));
    return responses;
  }

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
