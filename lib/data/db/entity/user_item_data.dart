import 'package:dairo/data/api/model/user_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class UserItemData {
  UserItemData();

  factory UserItemData.fromResponse(UserResponse response) => UserItemData();
}
