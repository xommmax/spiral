import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String uid;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? email;
  @JsonKey(name: 'phone_number',)
  final String? phoneNumber;

  const UserResponse({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
