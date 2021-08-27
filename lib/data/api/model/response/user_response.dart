import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String id;
  final String? name;
  final String? username;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final int? followingsCount;

  UserResponse({
    required this.id,
    required this.name,
    required this.username,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.followingsCount,
  });

  factory UserResponse.fromJson(
    Map<String, dynamic>? json, {
    String? id,
  }) {
    json = json ?? {};
    if (id != null) {
      json['id'] = id;
    }
    return _$UserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  String toString() {
    return 'UserResponse{id: $id, name: $name, username: $username, description: $description, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, followingsCount: $followingsCount}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          description == other.description &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          photoURL == other.photoURL &&
          followingsCount == other.followingsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      description.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      photoURL.hashCode ^
      followingsCount.hashCode;
}
