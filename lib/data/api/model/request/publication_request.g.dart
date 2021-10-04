// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationRequest _$PublicationRequestFromJson(Map<String, dynamic> json) =>
    PublicationRequest(
      hubId: json['hubId'] as String,
      userId: json['userId'] as String,
      text: json['text'] as String?,
      createdAt: json['createdAt'] as int,
      viewType: json['viewType'] as String,
      link: json['link'] as String?,
      attachedFileUrl: json['attachedFileUrl'] as String?,
    )
      ..mediaUrls =
          (json['mediaUrls'] as List<dynamic>).map((e) => e as String).toList()
      ..previewUrls = (json['previewUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$PublicationRequestToJson(PublicationRequest instance) =>
    <String, dynamic>{
      'hubId': instance.hubId,
      'userId': instance.userId,
      'text': instance.text,
      'createdAt': instance.createdAt,
      'mediaUrls': instance.mediaUrls,
      'previewUrls': instance.previewUrls,
      'viewType': instance.viewType,
      'link': instance.link,
      'attachedFileUrl': instance.attachedFileUrl,
    };
