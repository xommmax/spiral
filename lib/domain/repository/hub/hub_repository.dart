import 'package:dairo/domain/model/hub/hub.dart';

abstract class HubRepository {

  void refreshHubs({String? userId});

  Future<void> createHub(Hub hub);

  Stream<List<Hub>> getUserHubsStream({String? userId});
}
