import 'package:dairo/app/locator.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:injectable/injectable.dart';

import '../dairo_database.dart';

@lazySingleton
class HubLocalRepository {
  final DairoDatabase _database = locator<DairoDatabase>();

  Stream<List<HubItemData>> getHubs(String userId) =>
      _database.hubDao.getHubsStream(userId);

  Stream<HubItemData?> getHub(String hubId) =>
      _database.hubDao.getHubStream(hubId);

  Future<void> addHub(HubItemData hub) => _database.hubDao.insertHub(hub);

  Future<void> addHubs(List<HubItemData> hubs) =>
      _database.hubDao.insertHubs(hubs);

  Future<void> updateHub(HubItemData hub) => _database.hubDao.updateHub(hub);
}
