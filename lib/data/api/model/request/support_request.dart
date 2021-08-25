

import 'package:json_annotation/json_annotation.dart';


part 'support_request.g.dart';

@JsonSerializable()
class SupportRequest {
  final String subject;
  final String description;
  final int createdAt;

  const SupportRequest({
    required this.subject,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => _$SupportRequestToJson(this);

  @override
  String toString() {
    return 'SupportRequest{subject: $subject, description: $description, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportRequest &&
          runtimeType == other.runtimeType &&
          subject == other.subject &&
          description == other.description &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      subject.hashCode ^
      description.hashCode ^
      createdAt.hashCode;
}