import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/followers/followers_viewmodel.dart';
import 'package:dairo/presentation/view/tools/string_tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetFollowersAppBar extends ViewModelWidget<FollowersViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, FollowersViewModel viewModel) => AppBar(
        title: Text(
          viewModel.type == FollowersType.Likes
              ? Strings.likes
              : Strings.followers.capitalize(),
          style: TextStyles.toolbarTitle,
        ),
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
