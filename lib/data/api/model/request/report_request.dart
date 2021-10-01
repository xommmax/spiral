import 'package:json_annotation/json_annotation.dart';

part 'report_request.g.dart';

@JsonSerializable()
class ReportRequest {
  final String subjectId;
  final String subjectType;
  final String reporterId;
  final String reason;
  final int createdAt;

  ReportRequest({
    required this.subjectId,
    required this.subjectType,
    required this.reporterId,
    required this.reason,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() => _$ReportRequestToJson(this);

  @override
  String toString() {
    return 'ReportRequest{subjectId: $subjectId, subjectType: $subjectType, reporterId: $reporterId, reason: $reason, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportRequest &&
          runtimeType == other.runtimeType &&
          subjectId == other.subjectId &&
          subjectType == other.subjectType &&
          reporterId == other.reporterId &&
          reason == other.reason &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      subjectId.hashCode ^
      subjectType.hashCode ^
      reporterId.hashCode ^
      reason.hashCode ^
      createdAt.hashCode;
}
