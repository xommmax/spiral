import 'package:json_annotation/json_annotation.dart';

part 'like_publication_request.g.dart';

@JsonSerializable()
class LikePublicationRequest {
  final String publicationId;
  final String userId;
  final bool isLiked;

  const LikePublicationRequest({
    required this.publicationId,
    required this.userId,
    required this.isLiked,
  });

  @override
  String toString() {
    return 'LikePublicationRequest{isLiked: $isLiked, publicationId: $publicationId, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikePublicationRequest &&
          runtimeType == other.runtimeType &&
          isLiked == other.isLiked &&
          publicationId == other.publicationId &&
          userId == other.userId;

  @override
  int get hashCode =>
      isLiked.hashCode ^ publicationId.hashCode ^ userId.hashCode;

  Map<String, dynamic> toJson() => _$LikePublicationRequestToJson(this);
}
