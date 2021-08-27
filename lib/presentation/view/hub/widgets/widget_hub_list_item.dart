import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/material.dart';

class WidgetHubListItem extends StatelessWidget {
  final Hub _hub;
  final Function(Hub) onOpenHubDetailsClicked;

  const WidgetHubListItem(this._hub,
      {Key? key, required this.onOpenHubDetailsClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onOpenHubDetailsClicked(_hub),
        child: ListTile(
          leading: CircleAvatar(
            foregroundImage: CachedNetworkImageProvider(_hub.pictureUrl),
          ),
          title: Text(
            _hub.name,
            style: TextStyles.black14,
          ),
        ),
      );
}
