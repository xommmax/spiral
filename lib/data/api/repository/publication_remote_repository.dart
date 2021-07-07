import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/repository/firebase_storage_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PublicationRemoteRepository {
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();

  Future<void> sendPublication(
      PublicationRequest request, List<File> mediaFiles) async {
    List<String> uploadedUrls = [];
    if (mediaFiles.isNotEmpty) {
      uploadedUrls = await _firebaseStorageRepository.uploadFilesToUserFolder(
          mediaFiles, FirebaseStorageFolders.hubPublications);
    }
    if (uploadedUrls.isNotEmpty) {
      request.downloadedUrls = uploadedUrls;
    }
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.hubPublications)
        .doc()
        .set(request.toJson());
  }
}
