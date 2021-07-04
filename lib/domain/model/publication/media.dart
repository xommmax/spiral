class MediaFile {
  final String path;
  final MediaType type;

  const MediaFile({
    required this.path,
    required this.type,
  });
}

enum MediaType { image, video }
