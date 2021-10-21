import 'dart:io';

import 'package:dairo/presentation/view/tools/media_picker_widget/src/enums.dart';
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

  picker.Media toPickerMedia() {
    PickerMediaType pickerMediaType;
    if (type == MediaType.image)
      pickerMediaType = PickerMediaType.image;
    else if (type == MediaType.video)
      pickerMediaType = PickerMediaType.video;
    else
      throw ArgumentError();
    return picker.Media(id: id, mediaType: pickerMediaType);
  }

  @override
  String toString() {
    return 'LocalMediaFile{id: $id, originalFile: $originalFile, previewImage: $previewImage, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalMediaFile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          originalFile == other.originalFile &&
          previewImage == other.previewImage &&
          type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^
      originalFile.hashCode ^
      previewImage.hashCode ^
      type.hashCode;
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

  @override
  String toString() {
    return 'RemoteMediaFile{path: $path, type: $type, previewPath: $previewPath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoteMediaFile &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          type == other.type &&
          previewPath == other.previewPath;

  @override
  int get hashCode => path.hashCode ^ type.hashCode ^ previewPath.hashCode;
}

enum MediaType {
  image,
  video,
  audio,
}

enum MediaViewType {
  carousel,
  grid,
}
