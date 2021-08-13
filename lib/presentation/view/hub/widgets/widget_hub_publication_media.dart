import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/view/base/widget_video_preview.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHubPublicationMedia extends StatelessWidget {
  final List<String> mediaUrls;

  const WidgetHubPublicationMedia(this.mediaUrls, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget media;
    switch (mediaUrls.length) {
      case 1:
        media = _buildSingleMedia(0);
        break;
      case 2:
        media = _buildTwoMedias();
        break;
      case 3:
        media = _buildThreeMedias();
        break;
      default:
        media = _buildMoreMedias();
        break;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: media,
      ),
    );
  }

  Widget _buildSingleMedia(int position) =>
      Stack(
        children: [
          Positioned.fromRect(
            rect: Rect.fromPoints(Offset(400, 300), Offset(0, 0)),
            child: getUrlType(mediaUrls[position]) == UrlType.IMAGE ? CachedNetworkImage(
              imageUrl: mediaUrls[position],
              fit: BoxFit.fitWidth,
              width: double.maxFinite,
            ) : WidgetVideoPreview(
              networkUrl: mediaUrls[position],
            ),
          ),
        ],
      );

  Widget _buildTwoMedias({
    int? firstImagePosition,
    int? secondImagePosition,
  }) =>
      Row(
        children: [
          Expanded(
            flex: 49,
            child: _buildSingleMedia(firstImagePosition ?? 0),
          ),
          Expanded(
            flex: 1,
            child: Divider(
              height: 4,
            ),
          ),
          Expanded(
            flex: 49,
            child: _buildSingleMedia(secondImagePosition ?? 1),
          ),
        ],
      );

  Widget _buildThreeMedias() => Row(
        children: [
          Expanded(
            flex: 66,
            child: _buildSingleMedia(0),
          ),
          Expanded(
            flex: 1,
            child: Divider(
              height: 4,
            ),
          ),
          Expanded(
            flex: 33,
            child: Column(
              children: [
                Expanded(
                  flex: 49,
                  child: _buildSingleMedia(1),
                ),
                Expanded(
                  flex: 2,
                  child: Divider(
                    height: 1,
                  ),
                ),
                Expanded(
                  flex: 49,
                  child: _buildSingleMedia(2),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildMoreMedias() => Column(
        children: [
          Expanded(
            flex: 49,
            child: _buildTwoMedias(),
          ),
          Expanded(
            flex: 2,
            child: Divider(
              height: 1,
            ),
          ),
          Expanded(
            flex: 49,
            child: _buildTwoMedias(
              firstImagePosition: 2,
              secondImagePosition: 3,
            ),
          ),
        ],
      );
}
