import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/tools/string_extensions.dart';
import 'package:dairo/presentation/view/users/users_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../users_viewdata.dart';

class AppBarUsersLiked extends ViewModelWidget<UsersViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, UsersViewModel viewModel) => AppBar(
        centerTitle: true,
        title: Text(
          viewModel.type == UsersType.Likes
              ? Strings.likes
              : Strings.followers.capitalize(),
          style: TextStyles.white22Bold,
        ),
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}