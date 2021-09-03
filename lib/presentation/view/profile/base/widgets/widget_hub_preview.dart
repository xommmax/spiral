import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHubPreview extends StatelessWidget {
  final Hub _hub;

  const WidgetHubPreview(this._hub);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(15),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: _hub.pictureUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              _hub.isPrivate ? Icon(
                Icons.lock,
                color: Colors.blueGrey,
              ) : SizedBox.shrink(),
            ],
          ),
          Text(
            _hub.name,
            style: TextStyles.black14,
          ),
        ],
      );
}
