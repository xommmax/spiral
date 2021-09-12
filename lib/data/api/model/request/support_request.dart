import 'package:json_annotation/json_annotation.dart';

part 'support_request.g.dart';

@JsonSerializable()
class SupportRequest {
  final String subject;
  final String description;
  final int createdAt;
  final String userId;

  const SupportRequest({
    required this.subject,
    required this.description,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() => _$SupportRequestToJson(this);

  @override
  String toString() {
    return 'SupportRequest{subject: $subject, description: $description, createdAt: $createdAt, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportRequest &&
          runtimeType == other.runtimeType &&
          subject == other.subject &&
          description == other.description &&
          createdAt == other.createdAt &&
          userId == other.userId;

  @override
  int get hashCode =>
      subject.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      userId.hashCode;
}
