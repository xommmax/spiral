import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(UserItemData user);

  @Query('SELECT * FROM user WHERE id = :userId')
  Stream<UserItemData?> getUserStream(String userId);

  @Query('SELECT * FROM user WHERE id = :userId')
  Future<UserItemData?> getUser(String userId);

  @Query('DELETE FROM user')
  Future<void> deleteUser();

  @transaction
  Future<void> updateUser(UserItemData user) async {
    await deleteUser();
    await insertUser(user);
  }
}
