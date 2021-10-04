import 'dart:convert';

import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:flutter/foundation.dart';

class Publication {
  final String id;
  final String hubId;
  final String userId;
  final int commentsCount;
  final int likesCount;
  final bool isLiked;
  final int createdAt;
  // Media Block
  final List<String> mediaUrls;
  final List<String> previewUrls;
  final MediaViewType viewType;
  // Text Block
  final String? text;
  // Link Block
  final String? link;
  // File Block
  final String? attachedFileUrl;

  Publication._({
    required this.id,
    required this.hubId,
    required this.userId,
    required this.commentsCount,
    required this.likesCount,
    required this.isLiked,
    required this.createdAt,
    required this.mediaUrls,
    required this.previewUrls,
    required this.viewType,
    required this.text,
    required this.link,
    required this.attachedFileUrl,
  });

  factory Publication.fromItemData(PublicationItemData itemData) =>
      Publication._(
        id: itemData.id,
        hubId: itemData.hubId,
        userId: itemData.userId,
        text: itemData.text,
        likesCount: itemData.likesCount,
        commentsCount: itemData.commentsCount,
        mediaUrls: jsonDecode(itemData.mediaUrls)?.cast<String>() ?? [],
        previewUrls: jsonDecode(itemData.previewUrls)?.cast<String>() ?? [],
        isLiked: itemData.isLiked,
        createdAt: itemData.createdAt,
        viewType: MediaViewType.values
            .firstWhere((e) => describeEnum(e) == itemData.viewType),
        link: itemData.link,
        attachedFileUrl: itemData.attachedFileUrl,
      );

  @override
  String toString() {
    return 'Publication{id: $id, hubId: $hubId, userId: $userId, commentsCount: $commentsCount, likesCount: $likesCount, isLiked: $isLiked, createdAt: $createdAt, mediaUrls: $mediaUrls, previewUrls: $previewUrls, viewType: $viewType, text: $text, link: $link, attachedFileUrl: $attachedFileUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Publication &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          userId == other.userId &&
          commentsCount == other.commentsCount &&
          likesCount == other.likesCount &&
          isLiked == other.isLiked &&
          createdAt == other.createdAt &&
          mediaUrls == other.mediaUrls &&
          previewUrls == other.previewUrls &&
          viewType == other.viewType &&
          text == other.text &&
          link == other.link &&
          attachedFileUrl == other.attachedFileUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      userId.hashCode ^
      commentsCount.hashCode ^
      likesCount.hashCode ^
      isLiked.hashCode ^
      createdAt.hashCode ^
      mediaUrls.hashCode ^
      previewUrls.hashCode ^
      viewType.hashCode ^
      text.hashCode ^
      link.hashCode ^
      attachedFileUrl.hashCode;
}
