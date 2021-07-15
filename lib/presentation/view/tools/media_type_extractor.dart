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
];

const _videoFormats = [
  'mp4',
  'mov',
  'wmv',
  'flv',
  'avi',
  'mkv',
  'webm',
];

UrlType getUrlType(String url) {
  try {
    Uri uri = Uri.parse(url);
    String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
    for (String format in _imageFormats) {
      if (typeString == format) {
        return UrlType.IMAGE;
      }
    }
    for (String format in _videoFormats) {
      if (typeString == format) {
        return UrlType.VIDEO;
      }
    }
  } catch (e, stacktrace) {
    print(e);
    print(stacktrace);
  }
  return UrlType.UNKNOWN;
}
