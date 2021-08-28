import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:dairo/data/api/firestore_keys.dart';
import 'package:dairo/data/api/model/request/comment_request.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/model/response/comment_response.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/firebase_storage_repository.dart';
import 'package:dairo/data/api/repository/hub_remote_repository.dart';
import 'package:dairo/data/api/repository/user_remote_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PublicationRemoteRepository {
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRemoteRepository _userRemoteRepository =
      locator<UserRemoteRepository>();

  Future<PublicationResponse> createPublication(
      PublicationRequest request, List<File>? mediaFiles) async {
    List<String> uploadedUrls = [];
    if (mediaFiles != null && mediaFiles.isNotEmpty) {
      uploadedUrls = await _firebaseStorageRepository.uploadMultipleFiles(
          mediaFiles, FirebaseStorageFolders.hubPublications);
    }
    request.mediaUrls = uploadedUrls;
    final snapshot = await _firestore
        .collection(FirebaseCollections.hubPublications)
        .add(request.toJson())
        .then((reference) => reference.get());
    return PublicationResponse.fromJson(
      snapshot.data(),
      id: snapshot.id,
      isLiked: false,
    );
  }

  Future<List<PublicationResponse>> fetchPublications(String hubId) =>
      _firestore
          .collection('${FirebaseCollections.hubPublications}')
          .where(FirestoreKeys.hubId, isEqualTo: hubId)
          .get()
          .then(
            (snap) => Future.wait(
              snap.docs.map(
                (doc) async => PublicationResponse.fromJson(
                  doc.data(),
                  id: doc.id,
                  isLiked: await isCurrentUserLiked(doc.id),
                ),
              ),
            ),
          );

  Future<List<PublicationResponse>> fetchFeedPublications(String userId) =>
      _firestore
          .collection(
          '${FirebaseCollections.userFeeds}/$userId/${FirebaseCollections.publications}')
          .get()
          .then(
            (snap) => Future.wait(
              snap.docs.map(
                    (doc) async => PublicationResponse.fromJson(
                  doc.data(),
                  id: doc.id,
                  isLiked: await isCurrentUserLiked(doc.id),
                ),
              ),
            ),
          );

  Stream<Future<PublicationResponse>> fetchPublicationStream(
          String publicationId) =>
      _firestore
          .doc('${FirebaseCollections.hubPublications}/$publicationId')
          .snapshots()
          .map(
            (doc) async => PublicationResponse.fromJson(
              doc.data(),
              id: doc.id,
              isLiked: await isCurrentUserLiked(doc.id),
            ),
          );

  Future<bool> isCurrentUserLiked(
    String publicationId,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return false;
    bool isExist = await _firestore
        .doc(
            '${FirebaseCollections.publicationLikes}/$publicationId/${FirebaseCollections.users}/${currentUser.uid}')
        .get()
        .then((result) => result.exists);
    return isExist;
  }

  Future<List<String>> fetchUsersLiked(String publicationId) => _firestore
      .collection(
          '${FirebaseCollections.publicationLikes}/$publicationId/${FirebaseCollections.users}')
      .get()
      .then((result) => result.docs.map((doc) => doc.id).toList());

  Future<void> sendLike({
    required String publicationId,
    required String userId,
    required bool isLiked,
  }) async {
    final path =
        '${FirebaseCollections.publicationLikes}/$publicationId/${FirebaseCollections.users}/$userId';
    if (isLiked) {
      await _firestore.doc(path).set({});
    } else {
      await _firestore.doc(path).delete();
    }
  }

  Future<CommentResponse> sendComment(
      CommentRequest request, String publicationId) async {
    final snapshot = await _firestore
        .collection(
            '${FirebaseCollections.publicationComments}/$publicationId/${FirebaseCollections.comments}')
        .add(request.toJson())
        .then((reference) => reference.get());
    final UserResponse? user = await _userRemoteRepository
        .fetchUser(snapshot.get(FirestoreKeys.userId));
    return CommentResponse.fromJson(
      snapshot.data(),
      id: snapshot.id,
      publicationId: publicationId,
      user: user,
    );
  }

  Future<List<CommentResponse>> fetchComments(String publicationId) =>
      _firestore
          .collection('${FirebaseCollections.publicationComments}/'
              '$publicationId/${FirebaseCollections.comments}')
          .get()
          .then(
            (reference) => Future.wait(
              reference.docs.map(
                (doc) async => CommentResponse.fromJson(
                  doc.data(),
                  id: doc.id,
                  publicationId: publicationId,
                  user: await _userRemoteRepository.fetchUser(
                    doc.get(FirestoreKeys.userId),
                  ),
                ),
              ),
            ),
          );

  Future<List<CommentResponse>> fetchCommentReplies({
    required String publicationId,
    required String parentCommentId,
  }) =>
      _firestore
          .collection('${FirebaseCollections.publicationComments}/'
              '$publicationId/${FirebaseCollections.comments}')
          .where(FirestoreKeys.parentCommentId, isEqualTo: parentCommentId)
          .get()
          .then(
            (reference) => Future.wait(
              reference.docs.map(
                (doc) async => CommentResponse.fromJson(
                  doc.data(),
                  id: doc.id,
                  publicationId: publicationId,
                  user: await _userRemoteRepository.fetchUser(
                    doc.get(FirestoreKeys.userId),
                  ),
                ),
              ),
            ),
          );
}
