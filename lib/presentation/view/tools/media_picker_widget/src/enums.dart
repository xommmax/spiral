import 'package:dairo/domain/model/publication/media.dart' as publication;

enum MediaCount { single, multiple }

enum PickerMediaType {
  video,
  image,
  audio,
  common,
}

enum ActionBarPosition { top, bottom }

extension MediaTypeExtension on PickerMediaType {
  publication.MediaType toPubMediaType() {
    if (this == PickerMediaType.image)
      return publication.MediaType.image;
    else if (this == PickerMediaType.video)
      return publication.MediaType.video;
    else if (this == PickerMediaType.audio)
      return publication.MediaType.audio;
    else
      throw ArgumentError();
  }
}
