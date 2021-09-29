import 'dart:io';

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
