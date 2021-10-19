// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubResponse _$HubResponseFromJson(Map<String, dynamic> json) => HubResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      createdAt: json['createdAt'] as int,
      followersCount: json['followersCount'] as int,
      isFollow: json['isFollow'] as bool,
      orderIndex: json['orderIndex'] as int,
      isPrivate: json['isPrivate'] as bool,
      isDiscussionEnabled: json['isDiscussionEnabled'] as bool,
    );

Map<String, dynamic> _$HubResponseToJson(HubResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'pictureUrl': instance.pictureUrl,
      'createdAt': instance.createdAt,
      'followersCount': instance.followersCount,
      'isFollow': instance.isFollow,
      'isPrivate': instance.isPrivate,
      'isDiscussionEnabled': instance.isDiscussionEnabled,
      'orderIndex': instance.orderIndex,
    };
