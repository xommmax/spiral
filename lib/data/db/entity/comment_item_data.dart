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
  final int repliesCount;
  final String? parentCommentId;

  const CommentItemData({
    required this.id,
    required this.user,
    required this.publicationId,
    required this.text,
    required this.createdAt,
    required this.repliesCount,
    this.parentCommentId,
  });

  factory CommentItemData.fromResponse(CommentResponse commentResponse) =>
      CommentItemData(
        id: commentResponse.id,
        user: jsonEncode(commentResponse.user),
        publicationId: commentResponse.publicationId,
        text: commentResponse.text,
        createdAt: commentResponse.createdAt,
        parentCommentId: commentResponse.parentCommentId,
        repliesCount: commentResponse.repliesCount,
      );

  @override
  String toString() {
    return 'CommentItemData{id: $id, publicationId: $publicationId, user: $user, text: $text, createdAt: $createdAt, parentCommentId: $parentCommentId, repliesCount: $repliesCount}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          publicationId == other.publicationId &&
          user == other.user &&
          text == other.text &&
          createdAt == other.createdAt &&
          parentCommentId == other.parentCommentId &&
          repliesCount == other.repliesCount;

  @override
  int get hashCode =>
      id.hashCode ^
      publicationId.hashCode ^
      user.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      parentCommentId.hashCode ^
      repliesCount.hashCode;
}
