import 'package:firebase_auth/firebase_auth.dart' as firebase;
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

  UserRequest({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    this.username,
    this.description,
  });

  factory UserRequest.fromFirebase(firebase.User firebaseUser) => UserRequest(
        id: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email,
        phoneNumber: firebaseUser.phoneNumber,
        photoURL: firebaseUser.photoURL,
      );

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

  @override
  String toString() {
    return 'UserRequest{id: $id, displayName: $name, username: $username, description: $description, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
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
