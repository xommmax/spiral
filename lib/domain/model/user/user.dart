import 'package:dairo/data/db/entity/user_item_data.dart';

class User {
  final String id;
  final String? name;
  final String? username;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  User._({
    required this.id,
    required this.name,
    required this.username,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory User.fromItemData(UserItemData itemData) => User._(
        id: itemData.id,
        name: itemData.name,
        username: itemData.username,
        description: itemData.description,
        email: itemData.email,
        phoneNumber: itemData.phoneNumber,
        photoURL: itemData.photoURL,
      );

  @override
  String toString() {
    return 'User{id: $id, displayName: $name, username: $username, description: $description, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          description == other.description &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          photoURL == other.photoURL;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      description.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      photoURL.hashCode;
}
