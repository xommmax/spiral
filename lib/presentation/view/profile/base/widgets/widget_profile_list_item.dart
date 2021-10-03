import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/default_widgets.dart';
import 'package:flutter/material.dart';

class WidgetProfileListItem extends StatelessWidget {
  final User _user;
  final Function(User) onProfileListItemClicked;

  const WidgetProfileListItem(this._user,
      {Key? key, required this.onProfileListItemClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onProfileListItemClicked(_user),
        child: ListTile(
          leading: (_user.photoURL != null)
              ? CircleAvatar(
                  foregroundImage: CachedNetworkImageProvider(_user.photoURL!),
                  radius: 24,
                )
              : DefaultProfileImage(radius: 24),
          title: Text(
            _user.name ?? _user.email ?? _user.phoneNumber ?? Strings.unknown,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: (_user.description != null && _user.description!.isNotEmpty)
              ? Text(
                  _user.description!,
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
