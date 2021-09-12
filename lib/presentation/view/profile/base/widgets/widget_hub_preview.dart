import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            child: Stack(alignment: Alignment.bottomLeft, children: [
              CachedNetworkImage(
                imageUrl: _hub.pictureUrl,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              _hub.isPrivate
                  ? Container(
                      color: AppColors.black,
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.lock,
                        color: AppColors.white,
                        size: 16,
                      ),
                    )
                  : SizedBox.shrink(),
            ]),
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
