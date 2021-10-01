import 'package:dairo/domain/model/publication/media.dart' as pub;

enum MediaCount { single, multiple }

enum MediaType { video, image, all }

enum ActionBarPosition { top, bottom }

extension MediaTypeExtension on MediaType {
  pub.MediaType toPubMediaType() {
    if (this == MediaType.image)
      return pub.MediaType.image;
    else if (this == MediaType.video)
      return pub.MediaType.video;
    else
      throw ArgumentError();
  }
}
