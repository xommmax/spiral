import 'package:json_annotation/json_annotation.dart';

part 'comment_request.g.dart';

@JsonSerializable()
class CommentRequest {
  final String userId;
  final String text;
  final int createdAt;
  final String? parentCommentId;

  const CommentRequest({
    required this.userId,
    required this.text,
    required this.createdAt,
    this.parentCommentId,
  });

  Map<String, dynamic> toJson() => _$CommentRequestToJson(this);

  @override
  String toString() {
    return 'CommentRequest{userId: $userId, text: $text, createdAt: $createdAt, parentCommentId: $parentCommentId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentRequest &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          text == other.text &&
          createdAt == other.createdAt &&
          parentCommentId == other.parentCommentId;

  @override
  int get hashCode =>
      userId.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      parentCommentId.hashCode;
}
