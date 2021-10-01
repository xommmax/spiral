// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRequest _$ReportRequestFromJson(Map<String, dynamic> json) =>
    ReportRequest(
      subjectId: json['subjectId'] as String,
      subjectType: json['subjectType'] as String,
      reporterId: json['reporterId'] as String,
      reason: json['reason'] as String,
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$ReportRequestToJson(ReportRequest instance) =>
    <String, dynamic>{
      'subjectId': instance.subjectId,
      'subjectType': instance.subjectType,
      'reporterId': instance.reporterId,
      'reason': instance.reason,
      'createdAt': instance.createdAt,
    };
