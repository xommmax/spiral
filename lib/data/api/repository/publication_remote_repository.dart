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
  final FirebaseFirestore _remote = FirebaseFirestore.instance;

  Future<void> sendPublication(
      PublicationRequest request, List<File>? mediaFiles) async {
    List<String> uploadedUrls = [];
    if (mediaFiles != null && mediaFiles.isNotEmpty) {
      uploadedUrls = await _firebaseStorageRepository.uploadFilesToUserFolder(
          mediaFiles, FirebaseStorageFolders.hubPublications);
    }
    if (uploadedUrls.isNotEmpty) {
      request.mediaUrls = uploadedUrls;
    }
    await _remote
        .collection(FirebaseCollections.hubPublications)
        .add(request.toJson());
  }

  Stream<List<PublicationResponse>> listenRemotePublications(String hubId) =>
      _remote
          .collection(FirebaseCollections.hubPublications)
          .where('hubId', isEqualTo: hubId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((document) =>
                    PublicationResponse.fromJson(document.id, document.data()))
                .toList(),
          );
}
