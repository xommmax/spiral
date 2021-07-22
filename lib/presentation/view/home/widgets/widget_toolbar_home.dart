import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/home/home_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetToolBarHome extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: Dimens.toolBarHeight,
        color: AppColors.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.appName,
              style: TextStyles.toolbarTitle,
            ),
            IconButton(
              onPressed: viewModel.onAccountIconClicked,
              icon: Hero(
                tag: 'profilePhoto',
                child: WidgetProfilePhoto(photoUrl: viewModel.user?.photoURL),
              ),
            ),
          ],
        ),
      );
}
