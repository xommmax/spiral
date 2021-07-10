import 'dart:async';

import 'package:dairo/domain/model/hub/hub.dart';

abstract class HubRepository {
  StreamSubscription subscribeToCurrentUserHubs();

  Future<void> createHub(Hub hub);

  Stream<List<Hub>> getUserHubsStream({String? userId});
}
