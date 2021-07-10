import 'dart:convert';

import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'publication')
class PublicationItemData {
  @primaryKey
  final String id;
  final String hubId;
  final String text;
  final String? mediaUrls;

  const PublicationItemData({
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
}
