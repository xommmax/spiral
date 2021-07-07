// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubResponse _$HubResponseFromJson(Map<String, dynamic> json) {
  return HubResponse(
    name: json['name'] as String,
    pictureUrl: json['picture_url'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$HubResponseToJson(HubResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'picture_url': instance.pictureUrl,
      'description': instance.description,
    };
