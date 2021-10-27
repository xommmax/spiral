import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final String id;
  final String? name;
  final String? username;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final int? age;
  final int? createdAt;

  UserRequest({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.username,
    required this.description,
    required this.age,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

  @override
  String toString() {
    return 'UserRequest{id: $id, name: $name, username: $username, description: $description, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, age: $age, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          description == other.description &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          photoURL == other.photoURL &&
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
      age.hashCode ^
      createdAt.hashCode;
}
