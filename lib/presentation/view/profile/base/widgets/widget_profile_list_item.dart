import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
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
          leading: _user.photoURL != null
              ? CircleAvatar(
                  foregroundImage: CachedNetworkImageProvider(_user.photoURL!),
                )
              : Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                  ),
                ),
          title: Text(
            _user.name ??
                _user.email ??
                _user.phoneNumber ??
                Strings.unknown,
            style: TextStyles.black14,
          ),
        ),
      );
}
