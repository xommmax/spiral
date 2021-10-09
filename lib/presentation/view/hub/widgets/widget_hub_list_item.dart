import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
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
            foregroundImage: getHubImageProvider(_hub),
            radius: 24,
          ),
          title: Text(
            _hub.name,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: (_hub.description != null && _hub.description!.isNotEmpty)
              ? Text(
                  _hub.description!,
                  style: TextStyle(
                    color: AppColors.darkGray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
        ),
      );
}
