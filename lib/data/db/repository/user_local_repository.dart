import 'package:dairo/app/locator.dart';
import 'package:dairo/data/db/dairo_database.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserLocalRepository {
  final DairoDatabase _database = locator<DairoDatabase>();

  Stream<UserItemData?> getUserStream() => _database.userDao.getUserStream();

  Future<UserItemData?> getUser() => _database.userDao.getUser();

  Future<void> updateUser(UserItemData user) =>
      _database.userDao.updateUser(user);

  Future<void> deleteUser() => _database.userDao.deleteUser();
}
