// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRequest _$CommentRequestFromJson(Map<String, dynamic> json) {
  return CommentRequest(
    userId: json['userId'] as String,
    text: json['text'] as String,
    createdAt: json['createdAt'] as int,
    commentReplyId: json['commentReplyId'] as String?,
  );
}

Map<String, dynamic> _$CommentRequestToJson(CommentRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'text': instance.text,
      'createdAt': instance.createdAt,
      'commentReplyId': instance.commentReplyId,
    };
