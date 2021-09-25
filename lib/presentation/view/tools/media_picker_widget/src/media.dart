import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'enums.dart';

class Media {
  File? file;
  String? id;
  Uint8List? thumbnail;
  Uint8List? mediaByte;
  Size? size;
  DateTime? creationTime;
  String? title;
  MediaType? mediaType;

  Media({
    this.id,
    this.file,
    this.thumbnail,
    this.mediaByte,
    this.size,
    this.creationTime,
    this.title,
    this.mediaType,
  });
}
