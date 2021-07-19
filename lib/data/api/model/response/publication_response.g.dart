// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationResponse _$PublicationResponseFromJson(Map<String, dynamic> json) {
  return PublicationResponse(
    id: json['id'] as String,
    hubId: json['hubId'] as String,
    text: json['text'] as String?,
    mediaUrls:
        (json['mediaUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PublicationResponseToJson(
        PublicationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hubId': instance.hubId,
      'text': instance.text,
      'mediaUrls': instance.mediaUrls,
    };
