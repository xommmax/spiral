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
  final String previewUrls;
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final int createdAt;
  final String viewType;
  final String? link;
  final String? attachedFileUrl;

  PublicationItemData({
    required this.id,
    required this.hubId,
    required this.userId,
    required this.text,
    required this.mediaUrls,
    required this.previewUrls,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.viewType,
    required this.link,
    required this.attachedFileUrl,
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
        previewUrls: jsonEncode(response.previewUrls),
        isLiked: response.isLiked,
        createdAt: response.createdAt,
        viewType: response.viewType,
        link: response.link,
        attachedFileUrl: response.attachedFileUrl,
      );

  @override
  String toString() {
    return 'PublicationItemData{id: $id, hubId: $hubId, userId: $userId, text: $text, mediaUrls: $mediaUrls, previewUrls: $previewUrls, isLiked: $isLiked, likesCount: $likesCount, commentsCount: $commentsCount, createdAt: $createdAt, viewType: $viewType, link: $link, attachedFileUrl: $attachedFileUrl}';
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
          previewUrls == other.previewUrls &&
          isLiked == other.isLiked &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount &&
          createdAt == other.createdAt &&
          viewType == other.viewType &&
          link == other.link &&
          attachedFileUrl == other.attachedFileUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      userId.hashCode ^
      text.hashCode ^
      mediaUrls.hashCode ^
      previewUrls.hashCode ^
      isLiked.hashCode ^
      likesCount.hashCode ^
      commentsCount.hashCode ^
      createdAt.hashCode ^
      viewType.hashCode ^
      link.hashCode ^
      attachedFileUrl.hashCode;
}
