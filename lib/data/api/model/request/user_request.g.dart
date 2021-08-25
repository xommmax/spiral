// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) {
  return UserRequest(
    id: json['id'] as String,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    photoURL: json['photoURL'] as String?,
    username: json['username'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'description': instance.description,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
    };
