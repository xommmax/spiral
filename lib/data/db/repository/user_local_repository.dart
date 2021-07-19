import 'package:dairo/app/locator.dart';
import 'package:dairo/data/db/dairo_database.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserLocalRepository {
  final DairoDatabase _database = locator<DairoDatabase>();

  Stream<UserItemData?> getUser(String userId) =>
      _database.userDao.getUserStream(userId);

  Future<void> addUser(UserItemData user) => _database.userDao.insertUser(user);

  Future<void> deleteUser(UserItemData user) =>
      _database.userDao.deleteUser(user);

  Future<void> deleteUserById(String userId) =>
      _database.userDao.deleteUserById(userId);
}
