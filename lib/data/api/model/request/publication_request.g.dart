// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationRequest _$PublicationRequestFromJson(Map<String, dynamic> json) {
  return PublicationRequest(
    hubId: json['hubId'] as String,
    text: json['text'] as String?,
  )..downloadedUrls = (json['downloadedUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList();
}

Map<String, dynamic> _$PublicationRequestToJson(PublicationRequest instance) =>
    <String, dynamic>{
      'hubId': instance.hubId,
      'text': instance.text,
      'downloadedUrls': instance.downloadedUrls,
    };
