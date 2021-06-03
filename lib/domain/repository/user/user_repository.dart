
import 'package:dairo/domain/model/user.dart';

abstract class UserRepository {

  Stream<User?> getUser();

  void refreshUser();
}