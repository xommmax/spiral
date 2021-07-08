import 'dart:io';

import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';

class Hub {
  String name;
  File picture;
  String description;

  Hub({
    required this.name,
    required this.picture,
    required this.description,
  });

  HubRequest toRequest(String userId) => HubRequest(
        userId: userId,
        name: name,
        description: description,
      );

  factory Hub.fromItemData(HubItemData itemData) => Hub(
        name: itemData.name,
        picture: File(itemData.pictureUrl),
        description: itemData.description,
      );

  @override
  String toString() => 'Hub(name: $name, picture: $picture, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Hub &&
      other.name == name &&
      other.picture == picture &&
      other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ picture.hashCode ^ description.hashCode;
}
