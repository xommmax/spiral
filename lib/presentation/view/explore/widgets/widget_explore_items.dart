import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
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

class WidgetExploreHub extends StatelessWidget {
  final Hub hub;
  final List<String> mediaUrls;
  final Function(Hub hub) onHubClicked;

  const WidgetExploreHub(
      {Key? key,
      required this.hub,
      required this.mediaUrls,
      required this.onHubClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onHubClicked(hub),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: hub.pictureUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 4,
                    bottom: 4,
                    child: Text(
                      hub.name,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  hub.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.darkGray,
                    fontSize: 14,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 3,
                child: Row(
                  children: mediaUrls
                      .map(
                        (url) => AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
