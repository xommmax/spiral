import 'dart:convert';

import 'package:dairo/data/api/model/response/comment_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'comment')
class CommentItemData {
  @primaryKey
  final String id;
  final String publicationId;
  final String user;
  final String text;
  final int createdAt;
  final String? commentReplyId;

  const CommentItemData({
    required this.id,
    required this.user,
    required this.publicationId,
    required this.text,
    required this.createdAt,
    this.commentReplyId,
  });

  factory CommentItemData.fromResponse(CommentResponse commentResponse) =>
      CommentItemData(
        id: commentResponse.id,
        user: jsonEncode(commentResponse.user),
        publicationId: commentResponse.publicationId,
        text: commentResponse.text,
        createdAt: commentResponse.createdAt,
        commentReplyId: commentResponse.commentReplyId,
      );

  @override
  String toString() {
    return 'CommentItemData{id: $id, publicationId: $publicationId, text: $text, createAt: $createdAt, commentReplyId: $commentReplyId, user: $user}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          publicationId == other.publicationId &&
          text == other.text &&
          createdAt == other.createdAt &&
          commentReplyId == other.commentReplyId &&
          user == other.user;

  @override
  int get hashCode =>
      id.hashCode ^
      publicationId.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      commentReplyId.hashCode ^
      user.hashCode;
}
