import 'dart:convert';

import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'publication')
class PublicationItemData {
  @primaryKey
  final String id;
  final String hubId;
  final String userId;
  final String? text;
  final String mediaUrls;
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final int createdAt;

  PublicationItemData({
    required this.id,
    required this.hubId,
    required this.userId,
    required this.text,
    required this.mediaUrls,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
  });

  factory PublicationItemData.fromResponse(PublicationResponse response) =>
      PublicationItemData(
        id: response.id,
        hubId: response.hubId,
        userId: response.userId,
        text: response.text,
        likesCount: response.likesCount,
        commentsCount: response.commentsCount,
        mediaUrls: jsonEncode(response.mediaUrls),
        isLiked: response.isLiked,
        createdAt: response.createdAt,
      );

  @override
  String toString() {
    return 'PublicationItemData{id: $id, hubId: $hubId, userId: $userId, text: $text, mediaUrls: $mediaUrls, isLiked: $isLiked, likesCount: $likesCount, commentsCount: $commentsCount, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          userId == other.userId &&
          text == other.text &&
          mediaUrls == other.mediaUrls &&
          isLiked == other.isLiked &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      userId.hashCode ^
      text.hashCode ^
      mediaUrls.hashCode ^
      isLiked.hashCode ^
      likesCount.hashCode ^
      commentsCount.hashCode ^
      createdAt.hashCode;
}
