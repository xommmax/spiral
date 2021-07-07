import 'dart:io';

import 'package:dairo/data/api/model/request/hub_request.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';

class Hub {
  String name;
  File picture;
  String description;

  Hub({required this.name, required this.picture, required this.description});

  HubRequest toRequest(String userId) =>
      HubRequest(userId: userId, name: name, description: description);

  factory Hub.fromItemData(HubItemData itemData) => Hub(
      name: itemData.name,
      picture: File(itemData.pictureUrl),
      description: itemData.description);
}
