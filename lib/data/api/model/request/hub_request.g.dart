// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubRequest _$HubRequestFromJson(Map<String, dynamic> json) {
  return HubRequest(
    userId: json['userId'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  )..pictureUrl = json['pictureUrl'] as String?;
}

Map<String, dynamic> _$HubRequestToJson(HubRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'pictureUrl': instance.pictureUrl,
    };
