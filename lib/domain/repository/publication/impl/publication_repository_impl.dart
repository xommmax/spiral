import 'dart:async';
import 'dart:convert';

import 'package:dairo/app/analytics.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_documents.dart';
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
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PublicationRepository)
class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationRemoteRepository _remote =
      locator<PublicationRemoteRepository>();
  final PublicationLocalRepository _local =
      locator<PublicationLocalRepository>();
  final UserRepository _userRepository = locator<UserRepository>();
  final AnalyticsRepository _analyticsRepository =
      locator<AnalyticsRepository>();

  @override
  Future<void> createPublication({
    required String hubId,
    required String? text,
    required String? link,
    required String? attachedFileUrl,
    List<LocalMediaFile>? mediaFiles,
    required MediaViewType viewType,
  }) async {
    final currentUserId = _userRepository.getCurrentUserId();
    PublicationRequest request = PublicationRequest(
      hubId: hubId,
      userId: currentUserId,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      viewType: describeEnum(viewType),
      link: link,
      attachedFileUrl: attachedFileUrl,
    );
    PublicationResponse response =
        await _remote.createPublication(request, mediaFiles);
    await _local.addPublication(PublicationItemData.fromResponse(response));
    _sendPublicationCreatedEvent(
      publicationId: response.id,
      hubId: response.hubId,
      userId: response.userId,
    );
  }

  Stream<List<String>> getPublications(String hubId) {
    _remote.fetchPublications(hubId).then((response) {
      final itemData =
          response.map((e) => PublicationItemData.fromResponse(e)).toList();
      _local.updatePublications(itemData, hubId);
    });

    return _local
        .getPublications(hubId)
        .map((itemData) => itemData.map((e) => e.id).toList());
  }

  @override
  Stream<List<Publication>> getOnboardingPublications() {
    _remote.fetchOnboardingPublications().then((response) {
      final itemData =
          response.map((e) => PublicationItemData.fromResponse(e)).toList();
      _local.updatePublications(itemData, FirebaseDocuments.onboardingHub);
    });

    return _local.getPublications(FirebaseDocuments.onboardingHub).map(
        (itemData) =>
            itemData.map((e) => Publication.fromItemData(e)).toList());
  }

  @override
  Stream<List<String>> getFeedPublicationIds() =>
      _remote.getFeedPublicationIds(_userRepository.getCurrentUserId());

  Stream<Publication?> getPublication(String publicationId) {
    _remote.fetchPublication(publicationId).then(
          (response) => _local
              .updatePublication(PublicationItemData.fromResponse(response)),
        );
    return _local.getPublication(publicationId).map((itemData) {
      if (itemData == null) return null;
      return Publication.fromItemData(itemData);
    });
  }

  @override
  Future<void> sendLike({
    required String publicationId,
    required bool isLiked,
  }) async {
    _local.updateLikeStatus(publicationId, isLiked);
    await _remote.sendLike(
      publicationId: publicationId,
      userId: _userRepository.getCurrentUserId(),
      isLiked: isLiked,
    );
    _sendUserLikedEvent(
      publicationId: publicationId,
      userId: _userRepository.getCurrentUserId(),
      isLiked: isLiked,
    );
  }

  @override
  Future<void> sendComment({
    required String publicationId,
    required String text,
    required int createAt,
    String? parentCommentId,
  }) async =>
      _remote
          .sendComment(
        CommentRequest(
          userId: _userRepository.getCurrentUserId(),
          text: text,
          createdAt: createAt,
          parentCommentId: parentCommentId,
        ),
        publicationId,
      )
          .then((CommentResponse response) {
        _sendUserLeftCommentEvent(
          publicationId: publicationId,
          userId: _userRepository.getCurrentUserId(),
          commentId: response.id,
        );
        _local.addComment(
          CommentItemData.fromResponse(response),
        );
      });

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

    return _local.getComments(publicationId).map(
          (comments) => comments
              .map((comment) => Comment.fromItemData(
                    comment,
                    UserItemData.fromResponse(
                      UserResponse.fromJson(
                        jsonDecode(comment.user),
                      ),
                    ),
                  ))
              .toList(),
        );
  }

  @override
  Future<List<String>> getUsersLiked(String publicationId) =>
      _remote.fetchUsersLiked(publicationId);

  @override
  Stream<List<Comment>> getCommentReplies({
    required String publicationId,
    required String parentCommentId,
  }) {
    _remote
        .fetchCommentReplies(
            publicationId: publicationId, parentCommentId: parentCommentId)
        .then((commentsResponse) {
      final itemDataList = commentsResponse
          .map(
            (commentResponse) => CommentItemData.fromResponse(commentResponse),
          )
          .toList();
      _local.updateCommentReplies(itemDataList, parentCommentId);
    });

    return _local.getCommentReplies(parentCommentId).map((comments) => comments
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

  void _sendPublicationCreatedEvent({
    required String publicationId,
    required String hubId,
    required String userId,
  }) =>
      _analyticsRepository.logEvent(
        name: AnalyticsEventKeys.userCreatedPublication,
        parameters: {
          AnalyticsEventPropertiesKeys.publicationId: publicationId,
          AnalyticsEventPropertiesKeys.hubId: hubId,
          AnalyticsEventPropertiesKeys.userId: userId,
        },
      );

  Future<void> _sendUserLikedEvent({
    required bool isLiked,
    required String publicationId,
    required String userId,
  }) =>
      _analyticsRepository.logEvent(
        name: isLiked
            ? AnalyticsEventKeys.userLikedPublication
            : AnalyticsEventKeys.userDislikedPublication,
        parameters: {
          AnalyticsEventPropertiesKeys.publicationId: publicationId,
          AnalyticsEventPropertiesKeys.userId: userId,
        },
      );

  Future<void> _sendUserLeftCommentEvent({
    required String publicationId,
    required String userId,
    required String commentId,
  }) =>
      _analyticsRepository.logEvent(
        name: AnalyticsEventKeys.userLeftComment,
        parameters: {
          AnalyticsEventPropertiesKeys.publicationId: publicationId,
          AnalyticsEventPropertiesKeys.userId: userId,
          AnalyticsEventPropertiesKeys.commentId: commentId,
        },
      );

  @override
  Future<void> deletePublication({required String publicationId}) async {
    final response = await _remote.deletePublication(publicationId);
    await _local.deletePublication(PublicationItemData.fromResponse(response));
  }
}
