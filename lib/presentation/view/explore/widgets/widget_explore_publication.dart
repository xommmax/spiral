import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_explore_video_preview.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
import 'package:flutter/material.dart';

class WidgetExplorePublication extends StatelessWidget {
  final Publication publication;
  final Function(Publication publication) onPublicationClicked;

  const WidgetExplorePublication(
      {Key? key,
      required this.publication,
      required this.onPublicationClicked});

  @override
  Widget build(BuildContext context) {
    if (publication.mediaUrls.isNotEmpty) {
      final previewMediaUrl = publication.mediaUrls[0];

      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onPublicationClicked(publication),
          child: getUrlType(previewMediaUrl) == UrlType.IMAGE
              ? CachedNetworkImage(
                  imageUrl: previewMediaUrl,
                  fit: BoxFit.fitWidth,
                  width: double.maxFinite,
                )
              : getUrlType(previewMediaUrl) == UrlType.VIDEO
                  ? Stack(
                      children: [
                        Positioned.fromRect(
                          rect: Rect.fromPoints(Offset(400, 120), Offset(0, 0)),
                          child: WidgetExploreVideoPreview(
                              networkUrl: previewMediaUrl),
                        ),
                      ],
                    )
                  : SizedBox.shrink());
    } else if (publication.text != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onPublicationClicked(publication),
        child: Text(publication.text!),
      );
    } else
      return Text(Strings.errorLoadingPublication);
  }
}
