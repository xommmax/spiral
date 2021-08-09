
import 'package:dairo/data/db/entity/comment_item_data.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/domain/model/user/user.dart';

class Comment {
  final String id;
  final String publicationId;
  final User user;
  final String text;
  final String? commentReplyId;
  final int createdAt;

  const Comment._({
    required this.id,
    required this.publicationId,
    required this.user,
    required this.text,
    required this.createdAt,
    this.commentReplyId,
  });

  factory Comment.fromItemData(
          CommentItemData commentItemData, UserItemData userItemData) =>
      Comment._(
        id: commentItemData.id,
        publicationId: commentItemData.publicationId,
        user: User.fromItemData(userItemData),
        text: commentItemData.text,
        commentReplyId: commentItemData.commentReplyId,
        createdAt: commentItemData.createdAt,
      );

  @override
  String toString() {
    return 'Comment{id: $id, publicationId: $publicationId, user: $user, text: $text, commentReplyId: $commentReplyId, createdAt: $createdAt}';
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
          commentReplyId == other.commentReplyId &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      publicationId.hashCode ^
      user.hashCode ^
      text.hashCode ^
      commentReplyId.hashCode ^
      createdAt.hashCode;
}
