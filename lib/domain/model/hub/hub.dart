import 'dart:io';

import 'package:dairo/data/api/model/request/hub_request.dart';

class Hub {
  String name;
  File picture;
  String description;

  Hub(this.name, this.picture, this.description);

  HubRequest toRequest(String userId) =>
      HubRequest(userId: userId, name: name, description: description);
}
