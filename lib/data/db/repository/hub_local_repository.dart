import 'package:dairo/app/locator.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:injectable/injectable.dart';

import '../dairo_database.dart';

@lazySingleton
class HubLocalRepository {
  final DairoDatabase _database = locator<DairoDatabase>();

  Future<void> addHub(HubItemData hub) => _database.hubDao.insertHub(hub);

  Stream<HubItemData?> getHubCreationStream() =>
      _database.hubDao.getHubCreationStream();
}
