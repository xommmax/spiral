import 'package:dairo/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final String uid;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  const UserRequest({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserRequest.fromDomain(User user) => UserRequest(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
      );

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
