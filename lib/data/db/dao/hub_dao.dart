import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class HubDao {
  @Query('SELECT * FROM hub WHERE userId = :userId ORDER BY orderIndex ASC')
  Stream<List<HubItemData>> getHubs(String userId);

  @Query('SELECT * FROM hub WHERE id = :id')
  Stream<HubItemData?> getHub(String id);

  @Query('SELECT * FROM hub WHERE id = :id')
  Future<HubItemData?> getHubById(String id);

  @Query('SELECT * FROM hub WHERE id IN (:hubIds) ORDER BY createdAt DESC')
  Stream<List<HubItemData>> getHubsByIds(List<String> hubIds);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHub(HubItemData hub);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHubs(List<HubItemData> hubs);

  @delete
  Future<void> deleteHub(HubItemData hub);

  @Query('DELETE FROM hub WHERE id = :id')
  Future<void> deleteHubById(String id);

  @Query('DELETE FROM hub WHERE userId = :userId')
  Future<void> deleteHubsById(String userId);

  @transaction
  Future<void> updateHub(HubItemData hub) async {
    await deleteHubById(hub.id);
    await insertHub(hub);
  }

  @transaction
  Future<void> updateHubs(List<HubItemData> hubs, String userId) async {
    await deleteHubsById(userId);
    await insertHubs(hubs);
  }

  @transaction
  Future<void> updateFollowStatus(String hubId, bool follow) async {
    HubItemData? hub = await getHubById(hubId);
    if (hub == null) return;
    hub.isFollow = follow;
    return updateHub(hub);
  }
}
