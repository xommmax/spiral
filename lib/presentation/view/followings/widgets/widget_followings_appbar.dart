import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/followings/followings_viewmodel.dart';
import 'package:dairo/presentation/view/tools/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetFollowingsAppBar extends ViewModelWidget<FollowingsViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, FollowingsViewModel viewModel) => AppBar(
        title: Text(
          Strings.followings.capitalize(),
          style: TextStyles.toolbarTitle,
        ),
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
