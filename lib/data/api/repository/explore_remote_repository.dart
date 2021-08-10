import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExploreRemoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserResponse>> searchProfiles(String searchQuery) => _firestore
      .collection(FirebaseCollections.users)
      .where('displayName',
          isGreaterThanOrEqualTo: searchQuery,
          isLessThanOrEqualTo: searchQuery + '\uf8ff')
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => UserResponse.fromJson(doc.id, doc.data()))
          .toList());

  Future<List<HubResponse>> searchHubs(String searchQuery) => _firestore
      .collection(FirebaseCollections.userHubs)
      .where('name',
          isGreaterThanOrEqualTo: searchQuery,
          isLessThanOrEqualTo: searchQuery + '\uf8ff')
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => HubResponse.fromJson(doc.id, doc.data()))
          .toList());

  Future<List<PublicationResponse>> fetchExplorePublications() => _firestore
      .collection(FirebaseCollections.hubPublications)
      .orderBy("createdAt", descending: true)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => PublicationResponse.fromJson(doc.data(), id: doc.id))
          .toList());
}
