import 'dart:io';
import 'dart:math';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

Future<File> compressImage(String path, int quality) async {
  final newPath = p.join((await getTemporaryDirectory()).path,
      '${DateTime.now()}.${p.extension(path)}');
  final result = await FlutterImageCompress.compressAndGetFile(
    path,
    newPath,
    quality: quality,
  );
  return result!;
}

Future<File> compressVideo(String path) async {
  MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    path,
    quality: VideoQuality.Res1280x720Quality,
    deleteOrigin: false,
  );
  return File(mediaInfo!.path!);
}

String getFileSizeString(int byteSize, {int decimals = 1}) {
  if (byteSize <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(byteSize) / log(1024)).floor();
  return ((byteSize / pow(1024, i)).toStringAsFixed(decimals)) +
      ' ' +
      suffixes[i];
}
