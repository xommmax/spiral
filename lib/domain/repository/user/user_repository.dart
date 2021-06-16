import 'package:dairo/domain/model/base/result.dart';
import 'package:dairo/domain/model/user/user.dart';

abstract class UserRepository {
  Future<Result<User?>> getUser();

  Stream<Result<User?>> getUserStream();

  void updateUser(User user);

  void deleteUser();
}
