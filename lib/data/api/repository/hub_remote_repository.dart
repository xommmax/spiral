import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:injectable/injectable.dart';

import 'firebase_storage_repository.dart';

@lazySingleton
class HubRemoteRepository {
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createHub(HubRequest hubRequest, File hubPicture) async {
    List<String> uploadedUrls = await _firebaseStorageRepository
        .uploadFilesToUserFolder(
            [hubPicture], FirebaseStorageFolders.hubPictures);
    hubRequest.pictureUrl = uploadedUrls[0];
    await _firestore
        .collection(FirebaseCollections.userHubs)
        .add(hubRequest.toJson());
  }

  Future<List<HubResponse>> getHubs(String userId) => _firestore
      .collection(FirebaseCollections.userHubs)
      .where("userId", isEqualTo: userId)
      .get()
      .then((snapshots) => snapshots.docs
          .map((doc) => HubResponse.fromJson(doc.id, doc.data()))
          .toList());

  Stream<List<HubResponse>> listenRemoteHubs(String userId) => _firestore
      .collection(FirebaseCollections.userHubs)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((document) =>
                HubResponse.fromJson(document.id, document.data()))
            .toList(),
      );
}
