import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class UserItemData {
  @primaryKey
  final String id;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  UserItemData({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory UserItemData.fromResponse(UserResponse response) => UserItemData(
        id: response.id,
        displayName: response.displayName,
        email: response.email,
        phoneNumber: response.phoneNumber,
        photoURL: response.photoURL,
      );

  @override
  String toString() {
    return 'UserItemData{id: $id, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayName == other.displayName &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          photoURL == other.photoURL;

  @override
  int get hashCode =>
      id.hashCode ^
      displayName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      photoURL.hashCode;
}
