// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubRequest _$HubRequestFromJson(Map<String, dynamic> json) {
  return HubRequest(
    name: json['name'] as String,
    pictureUrl: json['pictureUrl'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$HubRequestToJson(HubRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
      'description': instance.description,
    };
