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

  Future<HubResponse> createHub(HubRequest hubRequest, File hubPicture) async {
    List<String> uploadedUrls = await _firebaseStorageRepository
        .uploadFilesToUserFolder(
            [hubPicture], FirebaseStorageFolders.hubPictures);
    hubRequest.pictureUrl = uploadedUrls[0];

    final snapshot = await _firestore
        .collection(FirebaseCollections.userHubs)
        .add(hubRequest.toJson())
        .then((reference) => reference.get());

    return HubResponse.fromJson(
      snapshot.data(),
      id: snapshot.id,
    );
  }

  Future<List<HubResponse>> fetchUserHubs(String userId) => _firestore
      .collection(FirebaseCollections.userHubs)
      .where("userId", isEqualTo: userId)
      .get()
      .then((snapshot) => snapshot.docs
          .map(
            (snapshot) => HubResponse.fromJson(
              snapshot.data(),
              id: snapshot.id,
            ),
          )
          .toList());
}
