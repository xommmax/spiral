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

  PublicationItemData({
    required this.id,
    required this.hubId,
    required this.text,
    required this.mediaUrls,
  });

  factory PublicationItemData.fromResponse(PublicationResponse response) =>
      PublicationItemData(
        id: response.id,
        hubId: response.hubId,
        text: response.text,
        mediaUrls: jsonEncode(response.mediaUrls),
      );

  @override
  String toString() {
    return 'PublicationItemData{id: $id, hubId: $hubId, text: $text, mediaUrls: $mediaUrls}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          text == other.text &&
          mediaUrls == other.mediaUrls;

  @override
  int get hashCode =>
      id.hashCode ^ hubId.hashCode ^ text.hashCode ^ mediaUrls.hashCode;
}
