import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/dairo_api.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:dairo/data/api/model/request/like_publication_request.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/repository/firebase_storage_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PublicationRemoteRepository {
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DairoApi _api = locator<DairoApi>();

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
    return PublicationResponse.fromJson(
      snapshot.data(),
      id: snapshot.id,
    );
  }

  Future<List<PublicationResponse>> fetchPublications(String hubId) =>
      _api.fetchPublications(hubId);

  Future<PublicationResponse> sendLike(LikePublicationRequest request) =>
      _api.sendLike(request);
}
