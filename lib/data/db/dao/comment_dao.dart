import 'package:dairo/data/db/entity/comment_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class CommentDao {
  @Query(
      'SELECT * FROM comment WHERE publicationId = :publicationId AND commentReplyId IS NULL ORDER BY createdAt DESC')
  Stream<List<CommentItemData>> getComments(String publicationId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComment(CommentItemData comment);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComments(List<CommentItemData> comments);

  @Query('DELETE FROM comment WHERE publicationId = :publicationId')
  Future<void> deleteComments(String publicationId);

  @transaction
  Future<void> updateComments(
      List<CommentItemData> comments, String publicationId) async {
    await deleteComments(publicationId);
    await insertComments(comments);
  }
}
