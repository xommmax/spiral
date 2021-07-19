import 'dart:convert';

import 'package:dairo/data/db/entity/publication_item_data.dart';

class Publication {
  final String id;
  final String hubId;
  final String? text;
  final List<String> mediaUrls;

  Publication._({
    required this.id,
    required this.hubId,
    required this.text,
    required this.mediaUrls,
  });

  factory Publication.fromItemData(PublicationItemData itemData) =>
      Publication._(
        id: itemData.id,
        hubId: itemData.hubId,
        text: itemData.text,
        mediaUrls: jsonDecode(itemData.mediaUrls).cast<String>(),
      );

  @override
  String toString() {
    return 'Publication{id: $id, hubId: $hubId, text: $text, mediaUrls: $mediaUrls}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Publication &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          text == other.text &&
          mediaUrls == other.mediaUrls;

  @override
  int get hashCode =>
      id.hashCode ^ hubId.hashCode ^ text.hashCode ^ mediaUrls.hashCode;
}
