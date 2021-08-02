// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_publication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikePublicationRequest _$LikePublicationRequestFromJson(
    Map<String, dynamic> json) {
  return LikePublicationRequest(
    publicationId: json['publicationId'] as String,
    userId: json['userId'] as String,
    isLiked: json['isLiked'] as bool,
  );
}

Map<String, dynamic> _$LikePublicationRequestToJson(
        LikePublicationRequest instance) =>
    <String, dynamic>{
      'publicationId': instance.publicationId,
      'userId': instance.userId,
      'isLiked': instance.isLiked,
    };
