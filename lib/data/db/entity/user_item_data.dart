import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class UserItemData {
  @primaryKey
  final String id;
  final String? name;
  final String? username;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final int? followingsCount;
  final int? age;

  UserItemData({
    required this.id,
    required this.name,
    required this.username,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.followingsCount,
    required this.age,
  });

  factory UserItemData.fromResponse(UserResponse response) => UserItemData(
        id: response.id,
        name: response.name,
        username: response.username,
        description: response.description,
        email: response.email,
        phoneNumber: response.phoneNumber,
        photoURL: response.photoURL,
        followingsCount: response.followingsCount,
        age: response.age,
      );

  @override
  String toString() {
    return 'UserItemData{id: $id, name: $name, username: $username, description: $description, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, followingsCount: $followingsCount, age: $age}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          description == other.description &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          photoURL == other.photoURL &&
          followingsCount == other.followingsCount &&
          age == other.age;

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
      age.hashCode;
}
