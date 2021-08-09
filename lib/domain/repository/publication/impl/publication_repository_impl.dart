import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/comment_request.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/model/response/comment_response.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/publication_remote_repository.dart';
import 'package:dairo/data/db/entity/comment_item_data.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/data/db/repository/publication_local_repository.dart';
import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PublicationRepository)
class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationRemoteRepository _remote =
      locator<PublicationRemoteRepository>();
  final PublicationLocalRepository _local =
      locator<PublicationLocalRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  Future<void> createPublication({
    required String hubId,
    String? text,
    List<MediaFile>? mediaFiles,
  }) async {
    _userRepository.checkAndGetCurrentUserId();
    final media = mediaFiles?.map((e) => File(e.path)).toList();
    PublicationRequest request = PublicationRequest(
      hubId: hubId,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    PublicationResponse response =
        await _remote.createPublication(request, media);
    await _local.addPublication(PublicationItemData.fromResponse(response));
  }

  Stream<List<Publication>> getHubPublications(String hubId) {
    _remote.fetchHubPublications(hubId).then((response) {
      final itemData =
          response.map((e) => PublicationItemData.fromResponse(e)).toList();
      _local.updatePublications(itemData, hubId);
    });

    return _local.getPublications(hubId).map((itemData) =>
        itemData.map((e) => Publication.fromItemData(e)).toList());
  }

  Stream<Publication?> getHubPublication(String publicationId) {
    _remote.fetchHubPublication(publicationId).then((response) =>
        _local.updatePublication(PublicationItemData.fromResponse(response)));
    return _local.getPublication(publicationId).map((itemData) {
      if (itemData == null) return null;
      return Publication.fromItemData(itemData);
    });
  }

  @override
  Future<void> sendLike({
    required String publicationId,
    required String userId,
    required bool isLiked,
  }) =>
      _remote.sendLike(
        publicationId: publicationId,
        userId: userId,
        isLiked: isLiked,
      );

  @override
  Future<void> sendComment({
    required String publicationId,
    required String userId,
    required String text,
    required int createAt,
    String? commentReplyId,
  }) async =>
      _remote
          .sendComment(
            CommentRequest(userId: userId, text: text, createdAt: createAt),
            publicationId,
          )
          .then(
            (CommentResponse response) => _local.addComment(
              CommentItemData.fromResponse(response),
            ),
          );

  @override
  Stream<List<Comment>> getComments(String publicationId) {
    _remote.fetchComments(publicationId).then((commentsResponse) {
      final itemDataList = commentsResponse
          .map(
            (commentResponse) => CommentItemData.fromResponse(commentResponse),
          )
          .toList();
      _local.updateComments(itemDataList, publicationId);
    });

    return _local.getComments(publicationId).map((comments) => comments
        .map((comment) => Comment.fromItemData(
              comment,
              UserItemData.fromResponse(
                UserResponse.fromJson(
                  jsonDecode(comment.user),
                ),
              ),
            ))
        .toList());
  }

  @override
  Future<List<String>> getUsersLiked(String publicationId) =>
      _remote.fetchUsersLiked(publicationId);
}
