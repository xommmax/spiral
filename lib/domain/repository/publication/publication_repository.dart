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

  Stream<List<Publication>> getHubPublications(String hubId);

  Stream<Publication?> getHubPublication(String publicationId);

  Future<void> sendLike({
    required String publicationId,
    required String userId,
    required bool isLiked,
  });

  Future<void> sendComment({
    required String publicationId,
    required String userId,
    required String text,
    required int createAt,
    String? commentReplyId,
  });

  Stream<List<Comment>> getComments(String publicationId);

  Future<List<String>> getUsersLiked(String publicationId);
}
