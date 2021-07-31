import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/publication/users_liked/users_liked_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarUsersLiked extends ViewModelWidget<UsersLikedViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, UsersLikedViewModel viewModel) => AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          Strings.likes,
          style: TextStyles.robotoWhiteBold22,
        ),
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}