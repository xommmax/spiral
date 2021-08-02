import 'package:json_annotation/json_annotation.dart';

part 'publication_response.g.dart';

@JsonSerializable()
class PublicationResponse {
  final String id;
  final String hubId;
  final String? text;
  final int likesCount;
  final List<String> usersLiked;
  final List<String> mediaUrls;
  final int createdAt;

  PublicationResponse({
    required this.id,
    required this.hubId,
    required this.text,
    required this.likesCount,
    required this.usersLiked,
    required this.mediaUrls,
    required this.createdAt,
  });

  factory PublicationResponse.fromJson(
    Map<String, dynamic>? json, {
    String? id,
  }) {
    json = json ?? {};
    json['id'] ??= id;
    json['usersLiked'] ??= [];
    json['mediaUrls'] ??= [];
    json['likesCount'] ??= 0;
    return _$PublicationResponseFromJson(json);
  }

  @override
  String toString() {
    return 'PublicationResponse{id: $id, hubId: $hubId, text: $text, likesCount: $likesCount, usersLiked: $usersLiked, mediaUrls: $mediaUrls, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          text == other.text &&
          likesCount == other.likesCount &&
          usersLiked == other.usersLiked &&
          mediaUrls == other.mediaUrls &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      text.hashCode ^
      likesCount.hashCode ^
      usersLiked.hashCode ^
      mediaUrls.hashCode ^
      createdAt.hashCode;
}
