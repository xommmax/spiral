import 'package:dairo/data/db/entity/user_item_data.dart';

class User {
  final String id;
  final String? name;
  final String? username;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final int? followingsCount;
  final int? age;
  final int? createdAt;

  User._({
    required this.id,
    required this.name,
    required this.username,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.followingsCount,
    required this.age,
    required this.createdAt,
  });

  factory User.fromItemData(UserItemData itemData) => User._(
        id: itemData.id,
        name: itemData.name,
        username: itemData.username,
        description: itemData.description,
        email: itemData.email,
        phoneNumber: itemData.phoneNumber,
        photoURL: itemData.photoURL,
        followingsCount: itemData.followingsCount,
        age: itemData.age,
        createdAt: itemData.createdAt,
      );

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, description: $description, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, followingsCount: $followingsCount, age: $age, createdAt: $createdAt}';
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
          photoURL == other.photoURL &&
          followingsCount == other.followingsCount &&
          age == other.age &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      description.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      photoURL.hashCode ^
      followingsCount.hashCode ^
      age.hashCode ^
      createdAt.hashCode;
}
