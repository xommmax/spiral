import 'dart:core';

enum UrlType {
  IMAGE,
  VIDEO,
  UNKNOWN,
}

const _imageFormats = [
  'jpg',
  'jpeg',
  'png',
  'gif',
  'heic',
  'heif',
];

const _videoFormats = [
  'mp4',
  'mov',
  'wmv',
  'flv',
  'avi',
  'mkv',
  'webm',
  'heic',
];

UrlType getUrlType(String url) {
  try {
    Uri uri = Uri.parse(url);
    String path = uri.path.toLowerCase();
    for (String format in _imageFormats) {
      if (path.endsWith(format)) {
        return UrlType.IMAGE;
      }
    }
    for (String format in _videoFormats) {
      if (path.endsWith(format)) {
        return UrlType.VIDEO;
      }
    }
  } catch (e, stacktrace) {
    print(e);
    print(stacktrace);
  }
  return UrlType.UNKNOWN;
}
