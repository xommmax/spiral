import 'package:json_annotation/json_annotation.dart';

part 'publication_response.g.dart';

@JsonSerializable()
class PublicationResponse {
  final String id;
  final String hubId;
  final String? text;
  final List<String>? mediaUrls;

  PublicationResponse({
    required this.id,
    required this.hubId,
    required this.text,
    required this.mediaUrls,
  });

  factory PublicationResponse.fromJson(String id, Map<String, dynamic>? json) {
    json = json ?? {};
    json['id'] = id;
    return _$PublicationResponseFromJson(json);
  }

  @override
  String toString() {
    return 'PublicationResponse{id: $id, hubId: $hubId, text: $text, mediaUrls: $mediaUrls}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hubId == other.hubId &&
          text == other.text &&
          mediaUrls == other.mediaUrls;

  @override
  int get hashCode =>
      id.hashCode ^ hubId.hashCode ^ text.hashCode ^ mediaUrls.hashCode;
}
