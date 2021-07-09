import 'package:dairo/domain/model/hub/hub.dart';

abstract class HubRepository {
  Future<void> createHub(Hub hub);

  Stream<List<Hub>> getAccountHubListStream();
}
