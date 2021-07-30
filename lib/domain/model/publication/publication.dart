import 'dart:convert';

import 'package:dairo/data/db/entity/publication_item_data.dart';

class Publication {
  final String id;
  final String hubId;
  final String? text;
  final int likesCount;
  final List<String> mediaUrls;
  final List<String> usersLiked;

  Publication._({
    required this.id,
    required this.hubId,
    required this.text,
    required this.likesCount,
    required this.mediaUrls,
    required this.usersLiked,
  });

  factory Publication.fromItemData(PublicationItemData itemData) =>
      Publication._(
        id: itemData.id,
        hubId: itemData.hubId,
        text: itemData.text,
        likesCount: itemData.likesCount,
        mediaUrls: jsonDecode(itemData.mediaUrls)?.cast<String>() ?? [],
        usersLiked: jsonDecode(itemData.usersLiked)?.cast<String>() ?? [],
      );

  @override
  String toString() {
    return 'Publication{id: $id, hubId: $hubId, text: $text, likesCount: $likesCount, mediaUrls: $mediaUrls, usersLiked: $usersLiked}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Publication &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          text == other.text &&
          likesCount == other.likesCount &&
          mediaUrls == other.mediaUrls &&
          usersLiked == other.usersLiked;

  @override
  int get hashCode =>
      id.hashCode ^
      hubId.hashCode ^
      text.hashCode ^
      likesCount.hashCode ^
      mediaUrls.hashCode ^
      usersLiked.hashCode;
}
