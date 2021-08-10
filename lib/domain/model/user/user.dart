import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';

class User {
  final String id;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  User._({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory User.fromItemData(UserItemData itemData) => User._(
        id: itemData.id,
        displayName: itemData.displayName,
        email: itemData.email,
        phoneNumber: itemData.phoneNumber,
        photoURL: itemData.photoURL,
      );

  @override
  String toString() {
    return 'User{id: $id, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
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
