import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class PublicationDao {
  @Query(
      'SELECT * FROM publication WHERE hubId = :hubId ORDER BY createdAt DESC')
  Stream<List<PublicationItemData>> getPublications(String hubId);

  @Query(
      'SELECT * FROM publication WHERE hubId IN (:hubIds) ORDER BY createdAt DESC')
  Stream<List<PublicationItemData>> getFeedPublications(List<String> hubIds);

  @Query('SELECT * FROM publication WHERE id = :publicationId')
  Stream<PublicationItemData?> getPublication(String publicationId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublication(PublicationItemData publication);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublications(List<PublicationItemData> publications);

  @Query('DELETE FROM publication WHERE hubId = :hubId')
  Future<void> deletePublications(String hubId);

  @Query('DELETE FROM publication WHERE id = :id')
  Future<void> deletePublication(String id);

  @transaction
  Future<void> updatePublication(PublicationItemData publication) async {
    await deletePublication(publication.id);
    await insertPublication(publication);
  }

  @transaction
  Future<void> updatePublications(
      List<PublicationItemData> publications, String hubId) async {
    await deletePublications(hubId);
    await insertPublications(publications);
  }
}
