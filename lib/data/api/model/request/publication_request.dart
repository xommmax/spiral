import 'package:json_annotation/json_annotation.dart';

part 'publication_request.g.dart';

@JsonSerializable()
class PublicationRequest {
  final String? hubId;
  final String? text;
  List<String>? mediaUrls;

  PublicationRequest({
    required this.hubId,
    this.text,
  });

  Map<String, dynamic> toJson() => _$PublicationRequestToJson(this);
}
