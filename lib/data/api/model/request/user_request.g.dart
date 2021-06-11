// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) {
  return UserRequest(
    uid: json['uid'] as String,
    displayName: json['display_name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phone_number'] as String?,
  );
}

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'display_name': instance.displayName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
    };
