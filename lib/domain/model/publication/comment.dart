import 'package:dairo/data/db/entity/comment_item_data.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/domain/model/user/user.dart';

class Comment {
  final String id;
  final String publicationId;
  final User user;
  final String text;
  final int createdAt;
  final int repliesCount;
  final String? parentCommentId;

  const Comment._({
    required this.id,
    required this.publicationId,
    required this.user,
    required this.text,
    required this.createdAt,
    required this.repliesCount,
    this.parentCommentId,
  });

  factory Comment.fromItemData(
          CommentItemData commentItemData, UserItemData userItemData) =>
      Comment._(
        id: commentItemData.id,
        publicationId: commentItemData.publicationId,
        user: User.fromItemData(userItemData),
        text: commentItemData.text,
        parentCommentId: commentItemData.parentCommentId,
        createdAt: commentItemData.createdAt,
        repliesCount: commentItemData.repliesCount,
      );

  @override
  String toString() {
    return 'Comment{id: $id, publicationId: $publicationId, user: $user, text: $text, createdAt: $createdAt, parentCommentId: $parentCommentId, repliesCount: $repliesCount}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
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
