import 'dart:io';

import 'package:dairo/presentation/view/tools/media_picker_widget/src/enums.dart'
    as picker_enums;
import 'package:dairo/presentation/view/tools/media_picker_widget/src/media.dart'
    as picker;

class LocalMediaFile {
  final String? id;
  final File originalFile;
  final File previewImage;
  final MediaType type;

  const LocalMediaFile({
    required this.id,
    required this.originalFile,
    required this.previewImage,
    required this.type,
  });

  picker.Media toPickerMedia() => picker.Media(id: id);

  static LocalMediaFile fromPickerMedia(picker.Media media, File previewImage) {
    MediaType mediaType = media.mediaType == picker_enums.MediaType.image
        ? MediaType.image
        : MediaType.video;
    return LocalMediaFile(
      id: media.id,
      originalFile: media.file!,
      previewImage: previewImage,
      type: mediaType,
    );
  }
}

class RemoteMediaFile {
  final String path;
  final MediaType type;
  final String previewPath;

  const RemoteMediaFile({
    required this.path,
    required this.type,
    required this.previewPath,
  });
}

enum MediaType {
  image,
  video,
}

enum MediaViewType {
  carousel,
  grid,
}
