import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class HubDao {
  @Query('SELECT * FROM hub WHERE userId = :userId ORDER BY createdAt DESC')
  Stream<List<HubItemData>> getHubs(String userId);

  @Query('SELECT * FROM hub WHERE id = :id')
  Stream<HubItemData?> getHub(String id);

  @Query('SELECT * FROM hub WHERE id IN (:hubIds) ORDER BY createdAt DESC')
  Stream<List<HubItemData>> getHubsByIds(List<String> hubIds);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHub(HubItemData hub);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHubs(List<HubItemData> hubs);

  @Query('DELETE FROM hub WHERE id = :id')
  Future<void> deleteHub(String id);

  @transaction
  Future<void> updateHub(HubItemData hub) async {
    await deleteHub(hub.id);
    await insertHub(hub);
  }
}
