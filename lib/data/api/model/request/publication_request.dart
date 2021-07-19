import 'package:json_annotation/json_annotation.dart';

part 'publication_request.g.dart';

@JsonSerializable()
class PublicationRequest {
  final String hubId;
  final String? text;
  List<String> mediaUrls = [];

  PublicationRequest({
    required this.hubId,
    required this.text,
  });

  Map<String, dynamic> toJson() => _$PublicationRequestToJson(this);

  @override
  String toString() {
    return 'PublicationRequest{hubId: $hubId, text: $text, mediaUrls: $mediaUrls}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationRequest &&
          runtimeType == other.runtimeType &&
          hubId == other.hubId &&
          text == other.text &&
          mediaUrls == other.mediaUrls;

  @override
  int get hashCode => hubId.hashCode ^ text.hashCode ^ mediaUrls.hashCode;
}
