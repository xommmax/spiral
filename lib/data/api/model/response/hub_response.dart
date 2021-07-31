import 'package:json_annotation/json_annotation.dart';

part 'hub_response.g.dart';

@JsonSerializable()
class HubResponse {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String pictureUrl;
  final int createdAt;

  HubResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.createdAt,
  });

  factory HubResponse.fromJson(String id, Map<String, dynamic>? json) {
    json = json ?? {};
    json['id'] = id;
    return _$HubResponseFromJson(json);
  }

  @override
  String toString() {
    return 'HubResponse{id: $id, userId: $userId, name: $name, description: $description, pictureUrl: $pictureUrl, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HubResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          description == other.description &&
          pictureUrl == other.pictureUrl &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      pictureUrl.hashCode ^
      createdAt.hashCode;
}
