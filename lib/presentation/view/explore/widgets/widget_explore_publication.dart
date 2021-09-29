import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
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
    if (publication.previewUrls.isNotEmpty) {
      final previewMediaUrl = publication.previewUrls[0];

      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onPublicationClicked(publication),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: previewMediaUrl,
              fit: BoxFit.cover,
              width: double.maxFinite,
            ),
            getUrlType(previewMediaUrl) == UrlType.VIDEO
                ? Align(
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0x80000000),
                      child: Icon(
                        Icons.play_arrow,
                        color: AppColors.white,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      );
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
