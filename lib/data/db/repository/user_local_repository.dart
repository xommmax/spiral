import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserLocalRepository {
  Stream<UserItemData?> getUser() => Stream.empty();

  Future<void> updateUser(UserItemData itemData) => Future.delayed(Duration(microseconds: 100));
}
