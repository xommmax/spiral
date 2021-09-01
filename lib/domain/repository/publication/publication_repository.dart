import 'dart:async';

import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';

abstract class PublicationRepository {
  Future<void> createPublication({
    required String hubId,
    String? text,
    List<MediaFile>? mediaFiles,
  });

  Stream<List<Publication>> getPublications(String hubId);

  Stream<List<Publication>> getFeedPublications();

  Stream<List<Publication>> getOnboardingPublications();

  Stream<Publication?> getPublication(String publicationId);

  Future<void> sendLike({
    required String publicationId,
    required bool isLiked,
  });

  Future<void> sendComment({
    required String publicationId,
    required String userId,
    required String text,
    required int createAt,
    String? parentCommentId,
  });

  Stream<List<Comment>> getComments(String publicationId);

  Future<List<String>> getUsersLiked(String publicationId);

  Stream<List<Comment>> getCommentReplies({
    required String publicationId,
    required String parentCommentId,
  });
}
