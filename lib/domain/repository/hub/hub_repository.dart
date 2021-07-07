import 'package:dairo/domain/model/base/result.dart';
import 'package:dairo/domain/model/hub/hub.dart';

abstract class HubRepository {
  Future<Result<Hub?>> createHub(Hub hub);

  dispose();
}
