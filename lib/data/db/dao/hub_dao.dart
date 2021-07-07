import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class HubDao {
  @insert
  Future<void> insertHub(HubItemData hub);

  @Query('SELECT * FROM hub')
  Stream<HubItemData?> getHubCreationStream();
}
