import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';

class Hub {
  final String? id;
  final String name;
  final String pictureUrl;
  final String description;

  Hub({
    this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
  });

  HubRequest toRequest(String userId) => HubRequest(
        userId: userId,
        name: name,
        description: description,
      );

  factory Hub.fromItemData(HubItemData itemData) => Hub(
        id: itemData.id,
        name: itemData.name,
        pictureUrl: itemData.pictureUrl,
        description: itemData.description,
      );

  @override
  String toString() {
    return 'Hub{id: $id, name: $name, pictureUrl: $pictureUrl, description: $description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hub &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          pictureUrl == other.pictureUrl &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ pictureUrl.hashCode ^ description.hashCode;
}
