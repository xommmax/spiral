import 'package:dairo/data/db/entity/hub_item_data.dart';

class Hub {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String pictureUrl;

  Hub._({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.pictureUrl,
  });

  factory Hub.fromItemData(HubItemData itemData) => Hub._(
        id: itemData.id,
        userId: itemData.userId,
        name: itemData.name,
        description: itemData.description,
        pictureUrl: itemData.pictureUrl,
      );

  @override
  String toString() {
    return 'Hub{id: $id, userId: $userId, name: $name, description: $description, pictureUrl: $pictureUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hub &&
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
