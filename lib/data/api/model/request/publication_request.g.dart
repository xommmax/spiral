// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationRequest _$PublicationRequestFromJson(Map<String, dynamic> json) {
  return PublicationRequest(
    hubId: json['hubId'] as String,
    userId: json['userId'] as String,
    text: json['text'] as String?,
    createdAt: json['createdAt'] as int,
    viewType: json['viewType'] as String,
  )..mediaUrls =
      (json['mediaUrls'] as List<dynamic>).map((e) => e as String).toList();
}

Map<String, dynamic> _$PublicationRequestToJson(PublicationRequest instance) =>
    <String, dynamic>{
      'hubId': instance.hubId,
      'userId': instance.userId,
      'text': instance.text,
      'createdAt': instance.createdAt,
      'mediaUrls': instance.mediaUrls,
      'viewType': instance.viewType,
    };
