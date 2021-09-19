import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class WidgetHubPreview extends StatelessWidget {
  final Hub _hub;

  const WidgetHubPreview(this._hub);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.all(15),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: AspectRatio(
              aspectRatio: Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
              child: Stack(alignment: Alignment.bottomLeft, children: [
                Container(
                  foregroundDecoration: _hub.isPrivate
                      ? const RotatedCornerDecoration(
                          color: AppColors.black,
                          geometry: const BadgeGeometry(
                              width: 42,
                              height: 42,
                              alignment: BadgeAlignment.bottomLeft),
                        )
                      : null,
                  child: CachedNetworkImage(
                    imageUrl: _hub.pictureUrl,
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                _hub.isPrivate
                    ? Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.lock_rounded,
                          color: AppColors.white,
                          size: 16,
                        ),
                      )
                    : SizedBox.shrink(),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _hub.name,
              style: TextStyles.black14,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
