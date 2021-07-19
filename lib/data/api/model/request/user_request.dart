import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final String id;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  UserRequest({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory UserRequest.fromFirebase(firebase.User firebaseUser) => UserRequest(
        id: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        email: firebaseUser.email,
        phoneNumber: firebaseUser.phoneNumber,
        photoURL: firebaseUser.photoURL,
      );

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

  @override
  String toString() {
    return 'UserRequest{id: $id, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRequest &&
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
