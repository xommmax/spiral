import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class UserItemData {
  @primaryKey
  final String uid;
  @ColumnInfo(name: 'display_name')
  final String? displayName;
  final String? email;
  @ColumnInfo(name: 'phone_number')
  final String? phoneNumber;

  const UserItemData({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserItemData.fromResponse(UserResponse response) => UserItemData(
        uid: response.uid,
        displayName: response.displayName,
        email: response.email,
        phoneNumber: response.phoneNumber,
      );
}
