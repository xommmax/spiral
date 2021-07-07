import 'package:dairo/data/db/entity/user_item_data.dart';

class User {
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  const User({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory User.fromItemData(UserItemData itemData) => User(
        uid: itemData.uid,
        displayName: itemData.displayName,
        email: itemData.email,
        phoneNumber: itemData.phoneNumber,
        photoURL: itemData.photoURL,
      );

  @override
  String toString() {
    return 'User{uid: $uid, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          displayName == other.displayName &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          photoURL == other.photoURL;

  @override
  int get hashCode =>
      uid.hashCode ^
      displayName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      photoURL.hashCode;
}
