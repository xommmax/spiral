import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class HubDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHub(HubItemData hub);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHubs(List<HubItemData> hubs);

  @Query("DELETE FROM hub WHERE userId = :userId")
  Future<void> deleteUserHubs(String userId);

  @Query('SELECT * FROM hub WHERE userId = :userId')
  Stream<List<HubItemData>> getUserHubsStream(String userId);

  @transaction
  Future<void> updateUserHubs(String userId, List<HubItemData> hubs) async {
    await deleteUserHubs(userId);
    await insertHubs(hubs);
  }
}
