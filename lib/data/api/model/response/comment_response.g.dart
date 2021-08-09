// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) {
  return CommentResponse(
    id: json['id'] as String,
    publicationId: json['publicationId'] as String,
    text: json['text'] as String,
    createdAt: json['createdAt'] as int,
    user: json['user'] == null
        ? null
        : UserResponse.fromJson(json['user'] as Map<String, dynamic>?),
    commentReplyId: json['commentReplyId'] as String?,
  );
}

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'createdAt': instance.createdAt,
      'publicationId': instance.publicationId,
      'commentReplyId': instance.commentReplyId,
      'user': instance.user,
    };
