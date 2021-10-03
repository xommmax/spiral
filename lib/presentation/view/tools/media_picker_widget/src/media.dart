import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'enums.dart';

class Media {
  File? file;
  String? id;
  Uint8List? thumbnail;
  Size? size;
  DateTime? creationTime;
  String? title;
  PickerMediaType? mediaType;

  Media({
    this.id,
    this.file,
    this.thumbnail,
    this.size,
    this.creationTime,
    this.title,
    this.mediaType,
  });

  static Future<Media> fromAssetEntity({required AssetEntity media}) async {
    Media convertedMedia = Media();
    convertedMedia.file = await media.file;
    convertedMedia.thumbnail = await media.thumbDataWithSize(200, 200);
    convertedMedia.id = media.id;
    convertedMedia.size = media.size;
    convertedMedia.title = media.title;
    convertedMedia.creationTime = media.createDateTime;

    PickerMediaType mediaType;
    if (media.type == AssetType.video)
      mediaType = PickerMediaType.video;
    else if (media.type == AssetType.image)
      mediaType = PickerMediaType.image;
    else if (media.type == AssetType.audio)
      mediaType = PickerMediaType.audio;
    else
      throw ArgumentError();
    convertedMedia.mediaType = mediaType;

    return convertedMedia;
  }
}
