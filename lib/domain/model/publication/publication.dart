import 'dart:convert';

import 'package:dairo/data/db/entity/publication_item_data.dart';

class Publication {
  final String id;
  final String hubId;
  final String userId;
  final String? text;
  final int likesCount;
  final int commentsCount;
  final List<String> mediaUrls;
  final bool isLiked;
  final int createdAt;

  Publication._({
    required this.id,
    required this.hubId,
    required this.userId,
    required this.text,
    required this.likesCount,
    required this.commentsCount,
    required this.mediaUrls,
    required this.isLiked,
    required this.createdAt,
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
        isLiked: itemData.isLiked,
        createdAt: itemData.createdAt,
      );

  @override
  String toString() {
    return 'Publication{id: $id, hubId: $hubId, userId: $userId, text: $text, likesCount: $likesCount, commentsCount: $commentsCount, mediaUrls: $mediaUrls, isLiked: $isLiked, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Publication &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          userId == other.userId &&
          text == other.text &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount &&
          mediaUrls == other.mediaUrls &&
          isLiked == other.isLiked &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      userId.hashCode ^
      text.hashCode ^
      likesCount.hashCode ^
      commentsCount.hashCode ^
      mediaUrls.hashCode ^
      isLiked.hashCode ^
      createdAt.hashCode;
}
