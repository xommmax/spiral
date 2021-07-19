import 'package:json_annotation/json_annotation.dart';

part 'hub_request.g.dart';

@JsonSerializable()
class HubRequest {
  final String userId;
  final String name;
  final String description;
  String? pictureUrl;

  HubRequest({
    required this.userId,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => _$HubRequestToJson(this);

  @override
  String toString() {
    return 'HubRequest{userId: $userId, name: $name, description: $description, pictureUrl: $pictureUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HubRequest &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          description == other.description &&
          pictureUrl == other.pictureUrl;

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      pictureUrl.hashCode;
}
