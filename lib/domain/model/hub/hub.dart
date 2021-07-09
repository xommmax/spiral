import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';

class Hub {
  String name;
  String pictureUrl;
  String description;

  Hub({
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
        name: itemData.name,
        pictureUrl: itemData.pictureUrl,
        description: itemData.description,
      );

  @override
  String toString() =>
      'Hub(name: $name, pictureUrl: $pictureUrl, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hub &&
        other.name == name &&
        other.pictureUrl == pictureUrl &&
        other.description == description;
  }

  @override
  int get hashCode =>
      name.hashCode ^ pictureUrl.hashCode ^ description.hashCode;
}
