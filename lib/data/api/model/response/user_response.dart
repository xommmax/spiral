import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String id;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  UserResponse({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
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
    return 'UserResponse{id: $id, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponse &&
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
