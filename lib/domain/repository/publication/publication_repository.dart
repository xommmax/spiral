import 'dart:async';

import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';

abstract class PublicationRepository {
  Future<void> createPublication({
    required String hubId,
    String? text,
    List<MediaFile>? mediaFiles,
  });

  Stream<List<Publication>> getHubPublications(String hubId);

  Future<void> sendLike({
    required String publicationId,
    required String userId,
    required bool isLiked,
  });
}
