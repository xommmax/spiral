import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../home_viewmodel.dart';

class AppBarHome extends ViewModelWidget<HomeViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) => AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          Strings.home,
          style: TextStyles.robotoWhiteBold22,
        ),
        actions: [
          IconButton(
            onPressed: viewModel.showAccountPage,
            icon: Hero(
              tag: 'profilePhoto',
              child: WidgetProfilePhoto(photoUrl: viewModel.getPhotoUrl()),
            ),
          ),
        ],
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
