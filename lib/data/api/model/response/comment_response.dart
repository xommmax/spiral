import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  final String id;
  final String text;
  final int createdAt;
  final String publicationId;
  final UserResponse? user;
  final int repliesCount;
  final String? parentCommentId;

  const CommentResponse({
    required this.id,
    required this.publicationId,
    required this.text,
    required this.createdAt,
    required this.user,
    required this.repliesCount,
    this.parentCommentId,
  });

  factory CommentResponse.fromJson(
    Map<String, dynamic>? json, {
    String? publicationId,
    String? id,
    UserResponse? user,
  }) {
    json = json ?? {};
    json['id'] = id;
    json['publicationId'] = publicationId;
    json['user'] = user?.toJson();
    json['repliesCount'] ??= 0;
    return _$CommentResponseFromJson(json);
  }

  @override
  String toString() {
    return 'CommentResponse{id: $id, text: $text, createdAt: $createdAt, publicationId: $publicationId, user: $user, parentCommentId: $parentCommentId, repliesCount: $repliesCount}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          createdAt == other.createdAt &&
          publicationId == other.publicationId &&
          user == other.user &&
          parentCommentId == other.parentCommentId &&
          repliesCount == other.repliesCount;

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      publicationId.hashCode ^
      user.hashCode ^
      parentCommentId.hashCode ^
      repliesCount.hashCode;
}
