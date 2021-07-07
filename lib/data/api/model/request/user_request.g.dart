// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) {
  return UserRequest(
    uid: json['uid'] as String,
    displayName: json['displayName'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    photoURL: json['photoURL'] as String?,
  );
}

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
    };
