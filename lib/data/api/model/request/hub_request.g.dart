// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubRequest _$HubRequestFromJson(Map<String, dynamic> json) => HubRequest(
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as int,
      isPrivate: json['isPrivate'] as bool,
      isDiscussionEnabled: json['isDiscussionEnabled'] as bool,
      pictureUrl: json['pictureUrl'] as String?,
    );

Map<String, dynamic> _$HubRequestToJson(HubRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'isPrivate': instance.isPrivate,
      'isDiscussionEnabled': instance.isDiscussionEnabled,
      'pictureUrl': instance.pictureUrl,
    };
