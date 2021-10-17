import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/auth/details/auth_details_viewmodel.dart';
import 'package:dairo/presentation/view/auth/widgets/buttons.dart';
import 'package:dairo/presentation/view/base/default_widgets.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class AuthDetailsPictureView extends StandardBaseView<AuthDetailsViewModel> {
  AuthDetailsPictureView()
      : super(
          locator<AuthDetailsViewModel>(),
          routeName: Routes.authDetailsPictureView,
          disposeViewModel: false,
        );

  @override
  Widget getContent(BuildContext context) => AuthDetailsPictureViewContent();
}

class AuthDetailsPictureViewContent
    extends ViewModelWidget<AuthDetailsViewModel> {
  @override
  Widget build(BuildContext context, AuthDetailsViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: viewModel.onChangeAvatarClicked,
                    child: Stack(
                      children: [
                        viewModel.viewData.photoUrl == null
                            ? WidgetProfilePhoto(
                                radius: 48,
                                photoUrl: viewModel.viewData.defaultPhotoUrl,
                              )
                            : CircleAvatar(
                                radius: 48,
                                foregroundImage: Image.file(
                                  File(viewModel.viewData.photoUrl!),
                                  fit: BoxFit.fitWidth,
                                ).image,
                                backgroundColor: Colors.transparent,
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightGray,
                            ),
                            child: Icon(Icons.edit,
                                size: 16, color: AppColors.darkAccentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    viewModel.viewData.name!,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                      "Choose a picture and write a bio to personalize your profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.gray,
                      )),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: viewModel.bioController,
                    autofocus: false,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.w200,
                    ),
                    maxLength: 150,
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    cursorColor: AppColors.white,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.gray, width: 0.5)),
                    ),
                  ),
                  SizedBox(height: 8),
                  NextButton(onPressed: viewModel.onBioNextClicked),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
