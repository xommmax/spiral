import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/base/default_widgets.dart';
import 'package:dairo/presentation/view/home/home_viewmodel.dart';
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
          color: AppColors.darkAccentColor,
          child: Stack(
            // fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: viewModel.onAccountIconClicked,
                  icon: Hero(
                    tag: 'profilePhoto',
                    child: WidgetProfilePhoto(
                      photoUrl: viewModel.viewData.user?.photoURL,
                      radius: 15,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      child: Image.asset(
                        'assets/images/spiral_home_logo.png',
                        width: 44,
                      ),
                    ),
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: IconButton(
              //     onPressed: viewModel.onMessageIconClicked,
              //     icon: Icon(
              //       Icons.message_outlined,
              //       color: AppColors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
}
