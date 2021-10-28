import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class PublicationDao {
  @Query(
      'SELECT * FROM publication WHERE hubId = :hubId ORDER BY createdAt DESC')
  Stream<List<PublicationItemData>> getPublications(String hubId);

  @Query('SELECT * FROM publication WHERE id = :publicationId')
  Stream<PublicationItemData?> getPublication(String publicationId);

  @Query('SELECT * FROM publication WHERE id = :publicationId')
  Future<PublicationItemData?> getPublicationById(String publicationId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublication(PublicationItemData publication);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublications(List<PublicationItemData> publications);

  @Query('DELETE FROM publication WHERE hubId = :hubId')
  Future<void> deletePublications(String hubId);

  @Query('DELETE FROM publication WHERE id = :id')
  Future<void> deletePublicationById(String id);

  @delete
  Future<void> deletePublication(PublicationItemData publication);

  @transaction
  Future<void> updatePublication(PublicationItemData publication) async {
    await deletePublicationById(publication.id);
    await insertPublication(publication);
  }

  @transaction
  Future<void> updatePublications(
      List<PublicationItemData> publications, String hubId) async {
    await deletePublications(hubId);
    await insertPublications(publications);
  }

  @transaction
  Future<void> updateLikeStatus(String publicationId, bool isLiked) async {
    PublicationItemData? publication = await getPublicationById(publicationId);
    if (publication == null) return;
    publication.isLiked = isLiked;
    if (isLiked)
      publication.likesCount++;
    else
      publication.likesCount--;
    return updatePublication(publication);
  }
}
