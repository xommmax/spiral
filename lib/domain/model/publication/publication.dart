import 'dart:convert';

import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:dairo/domain/model/publication/media.dart';

class Publication {
  String? id;
  String? hubId;
  String? text;
  List<MediaFile> mediaFiles = [];
  List<String>? mediaUrls;

  Publication();

  Publication.create({
    this.hubId,
    this.id,
    this.text,
    this.mediaUrls,
  });

  PublicationRequest toRequest() => PublicationRequest(
        hubId: hubId,
        text: text,
      );

  factory Publication.fromItemData(PublicationItemData itemData) =>
      Publication.create(
        id: itemData.id,
        hubId: itemData.hubId,
        text: itemData.text,
        mediaUrls:
            itemData.mediaUrls != null ? jsonDecode(itemData.mediaUrls!) : null,
      );
}
