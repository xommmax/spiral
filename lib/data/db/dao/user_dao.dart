import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM user WHERE id = :userId')
  Stream<UserItemData?> getUserStream(String userId);

  @Query('SELECT * FROM user WHERE id = :userId')
  Future<UserItemData?> getUser(String userId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(UserItemData user);

  @delete
  Future<void> deleteUser(UserItemData user);

  Future<void> deleteUserById(String userId) {
    return getUser(userId).then((user) {
      if (user != null) deleteUser(user);
    });
  }
}
