import 'dart:async';

import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';

abstract class HubRepository {
  Future<void> createHub({
    required String name,
    required String description,
    required MediaFile picture,
  });

  Stream<List<Hub>> getCurrentUserHubs();

  Stream<List<Hub>> getUserHubs(String userId);
}
