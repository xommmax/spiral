import 'package:json_annotation/json_annotation.dart';

part 'publication_response.g.dart';

@JsonSerializable()
class PublicationResponse {
  final String id;
  final String hubId;
  final String text;
  final List<String>? mediaUrls;

  const PublicationResponse({
    required this.id,
    required this.hubId,
    required this.text,
    required this.mediaUrls,
  });

  factory PublicationResponse.fromJson(String id, Map<String, dynamic> json) {
    json['id'] = id;
    return _$PublicationResponseFromJson(json);
  }
}
