import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/repository/firebase_storage_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PublicationRemoteRepository {
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<PublicationResponse> createPublication(
      PublicationRequest request, List<File>? mediaFiles) async {
    List<String> uploadedUrls = [];
    if (mediaFiles != null && mediaFiles.isNotEmpty) {
      uploadedUrls = await _firebaseStorageRepository.uploadFilesToUserFolder(
          mediaFiles, FirebaseStorageFolders.hubPublications);
    }
    request.mediaUrls = uploadedUrls;
    var snapshot = await _firestore
        .collection(FirebaseCollections.hubPublications)
        .add(request.toJson())
        .then((reference) => reference.get());
    return PublicationResponse.fromJson(snapshot.id, snapshot.data());
  }

  Future<List<PublicationResponse>> fetchHubPublications(
          String hubId) =>
      _firestore
          .collection(FirebaseCollections.hubPublications)
          .where('hubId', isEqualTo: hubId)
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => PublicationResponse.fromJson(doc.id, doc.data()))
              .toList());
}
