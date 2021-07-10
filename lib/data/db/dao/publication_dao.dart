import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class PublicationDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublication(PublicationItemData publication);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPublications(List<PublicationItemData> publication);

  @Query('SELECT * FROM publication WHERE hubId = :hubId')
  Stream<List<PublicationItemData>> getUserPublicationsStream(
    String hubId,
  );
}
