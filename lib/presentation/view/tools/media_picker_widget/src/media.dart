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
  MediaType? mediaType;

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

    MediaType mediaType = MediaType.all;
    if (media.type == AssetType.video) mediaType = MediaType.video;
    if (media.type == AssetType.image) mediaType = MediaType.image;
    convertedMedia.mediaType = mediaType;

    return convertedMedia;
  }
}
