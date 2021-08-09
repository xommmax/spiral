import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  final String id;
  final String text;
  final int createdAt;
  final String publicationId;
  final String? commentReplyId;
  final UserResponse? user;

  const CommentResponse({
    required this.id,
    required this.publicationId,
    required this.text,
    required this.createdAt,
    required this.user,
    this.commentReplyId,
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
    return _$CommentResponseFromJson(json);
  }

  @override
  String toString() {
    return 'CommentResponse{id: $id, text: $text, createAt: $createdAt, publicationId: $publicationId, commentReplyId: $commentReplyId, user: $user}';
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
          commentReplyId == other.commentReplyId &&
          user == other.user;

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      publicationId.hashCode ^
      commentReplyId.hashCode ^
      user.hashCode;
}
