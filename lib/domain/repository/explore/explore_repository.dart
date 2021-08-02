import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';

abstract class ExploreRepository {
  Future<List<User>> searchProfiles(String searchQuery);

  Future<List<Hub>> searchHubs(String searchQuery);
}
