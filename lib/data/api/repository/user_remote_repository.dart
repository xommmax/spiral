import 'package:dairo/data/api/model/user_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRemoteRepository {

  Future<UserResponse?> fetchUser() => Future.value();
}
