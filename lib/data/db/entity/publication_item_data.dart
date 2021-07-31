import 'dart:convert';

import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'publication')
class PublicationItemData {
  @primaryKey
  final String id;
  final String hubId;
  final String? text;
  final String mediaUrls;
  final String usersLiked;
  final int likesCount;
  final int createdAt;

  PublicationItemData({
    required this.id,
    required this.hubId,
    required this.text,
    required this.mediaUrls,
    required this.usersLiked,
    required this.likesCount,
    required this.createdAt,
  });

  factory PublicationItemData.fromResponse(PublicationResponse response) =>
      PublicationItemData(
        id: response.id,
        hubId: response.hubId,
        text: response.text,
        likesCount: response.likesCount,
        mediaUrls: jsonEncode(response.mediaUrls),
        usersLiked: jsonEncode(response.usersLiked),
        createdAt: response.createdAt,
      );

  @override
  String toString() {
    return 'PublicationItemData{id: $id, hubId: $hubId, text: $text, mediaUrls: $mediaUrls, usersLiked: $usersLiked, likesCount: $likesCount, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          text == other.text &&
          mediaUrls == other.mediaUrls &&
          usersLiked == other.usersLiked &&
          likesCount == other.likesCount &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      text.hashCode ^
      mediaUrls.hashCode ^
      usersLiked.hashCode ^
      likesCount.hashCode ^
      createdAt.hashCode;
}
