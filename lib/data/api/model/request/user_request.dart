import 'package:dairo/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final String id;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  const UserRequest({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory UserRequest.fromDomain(User user) => UserRequest(
        id: user.id,
        displayName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoURL: user.photoURL,
      );

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
