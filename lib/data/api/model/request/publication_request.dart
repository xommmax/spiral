import 'package:json_annotation/json_annotation.dart';

part 'publication_request.g.dart';

@JsonSerializable()
class PublicationRequest {
  final String hubId;
  final String userId;
  final String? text;
  final int createdAt;
  List<String> mediaUrls = [];
  List<String> previewUrls = [];
  final String viewType;

  PublicationRequest({
    required this.hubId,
    required this.userId,
    required this.text,
    required this.createdAt,
    required this.viewType,
  });

  Map<String, dynamic> toJson() => _$PublicationRequestToJson(this);

  @override
  String toString() {
    return 'PublicationRequest{hubId: $hubId, userId: $userId, text: $text, createdAt: $createdAt, mediaUrls: $mediaUrls, previewUrls: $previewUrls, viewType: $viewType}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicationRequest &&
          runtimeType == other.runtimeType &&
          hubId == other.hubId &&
          userId == other.userId &&
          text == other.text &&
          createdAt == other.createdAt &&
          mediaUrls == other.mediaUrls &&
          previewUrls == other.previewUrls &&
          viewType == other.viewType;

  @override
  int get hashCode =>
      hubId.hashCode ^
      userId.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      mediaUrls.hashCode ^
      previewUrls.hashCode ^
      viewType.hashCode;
}
