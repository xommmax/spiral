// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportRequest _$SupportRequestFromJson(Map<String, dynamic> json) {
  return SupportRequest(
    subject: json['subject'] as String,
    description: json['description'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$SupportRequestToJson(SupportRequest instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'description': instance.description,
      'createdAt': instance.createdAt,
    };
