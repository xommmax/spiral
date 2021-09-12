import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/home/home_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarHome extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) => Material(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: Dimens.toolBarHeight,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/spiral_home_logo.png',
                    width: 33,
                  ),
                  SizedBox(width: 3),
                  Text(
                    Strings.appName,
                    style: TextStyles.toolbarTitle
                        .copyWith(color: AppColors.accentColor),
                  ),
                ],
              ),
              IconButton(
                onPressed: viewModel.onAccountIconClicked,
                icon: Hero(
                  tag: 'profilePhoto',
                  child: WidgetProfilePhoto(
                    photoUrl: viewModel.viewData.user?.photoURL,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
