import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class PublicationDao {
  @Query('SELECT * FROM publication WHERE hubId = :hubId')
  Stream<List<PublicationItemData>> getHubPublicationsStream(String hubId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublication(PublicationItemData publication);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublications(List<PublicationItemData> publications);
}
