// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubResponse _$HubResponseFromJson(Map<String, dynamic> json) {
  return HubResponse(
    id: json['id'] as String,
    name: json['name'] as String,
    pictureUrl: json['pictureUrl'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$HubResponseToJson(HubResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
      'description': instance.description,
    };
