// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    uid: json['uid'] as String,
    displayName: json['display_name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phone_number'] as String?,
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'display_name': instance.displayName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
    };
