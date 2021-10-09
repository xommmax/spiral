import 'package:json_annotation/json_annotation.dart';

part 'support_request.g.dart';

@JsonSerializable()
class SupportRequest {
  final String type;
  final String? subject;
  final String? description;
  final String? email;
  final int createdAt;
  final String userId;

  const SupportRequest({
    required this.type,
    this.subject,
    this.description,
    this.email,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() => _$SupportRequestToJson(this);

  @override
  String toString() {
    return 'SupportRequest{type: $type, subject: $subject, description: $description, email: $email, createdAt: $createdAt, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportRequest &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          subject == other.subject &&
          description == other.description &&
          email == other.email &&
          createdAt == other.createdAt &&
          userId == other.userId;

  @override
  int get hashCode =>
      type.hashCode ^
      subject.hashCode ^
      description.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      userId.hashCode;
}
