import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/home/home_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetHomeViewContent extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(Strings.home),
          backgroundColor: AppColors.primaryColor,
          actions: [
            IconButton(
              onPressed: viewModel.showAccountPage,
              icon: Hero(
                tag: 'profilePhoto',
                child: WidgetProfilePhoto(photoUrl: viewModel.getPhotoUrl()),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Home",
              style: TextStyles.robotoBlack22,
            ),
          ),
        ),
      );
}
