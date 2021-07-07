import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class UserItemData {
  @primaryKey
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  const UserItemData({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory UserItemData.fromResponse(UserResponse response) => UserItemData(
        uid: response.uid,
        displayName: response.displayName,
        email: response.email,
        phoneNumber: response.phoneNumber,
        photoURL: response.photoURL,
      );
}
