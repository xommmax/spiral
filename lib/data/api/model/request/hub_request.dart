import 'package:json_annotation/json_annotation.dart';

part 'hub_request.g.dart';

@JsonSerializable()
class HubRequest {
  final String userId;
  final String name;
  final String? description;
  final int createdAt;
  final bool isPrivate;
  String? pictureUrl;

  HubRequest({
    required this.userId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.isPrivate,
  });

  Map<String, dynamic> toJson() => _$HubRequestToJson(this);

  @override
  String toString() {
    return 'HubRequest{userId: $userId, name: $name, description: $description, createdAt: $createdAt, isPrivate: $isPrivate, pictureUrl: $pictureUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HubRequest &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          description == other.description &&
          createdAt == other.createdAt &&
          isPrivate == other.isPrivate &&
          pictureUrl == other.pictureUrl;

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      isPrivate.hashCode ^
      pictureUrl.hashCode;
}
