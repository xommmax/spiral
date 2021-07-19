import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'hub')
class HubItemData {
  @primaryKey
  final String id;
  final String userId;
  final String name;
  final String description;
  final String pictureUrl;

  HubItemData({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.pictureUrl,
  });

  factory HubItemData.fromResponse(HubResponse response) => HubItemData(
        id: response.id,
        userId: response.userId,
        name: response.name,
        description: response.description,
        pictureUrl: response.pictureUrl,
      );

  @override
  String toString() {
    return 'HubItemData{id: $id, userId: $userId, name: $name, description: $description, pictureUrl: $pictureUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HubItemData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          description == other.description &&
          pictureUrl == other.pictureUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      pictureUrl.hashCode;
}
