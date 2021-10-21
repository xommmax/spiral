import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/default_images.dart';
import 'package:dairo/presentation/view/settings/edit_account/account_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetAccountDetailsAvatar
    extends ViewModelWidget<AccountDetailsViewModel> {
  @override
  Widget build(BuildContext context, AccountDetailsViewModel viewModel) =>
      InkWell(
        onTap: viewModel.onChangeAvatarClicked,
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          children: [
            viewModel.viewData.photoUrl == null
                ? WidgetProfilePhoto(
                    radius: 48,
                    photoUrl: viewModel.data?.photoURL,
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
                padding: EdgeInsets.all(0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGray,
                ),
                child: Icon(Icons.edit, size: 16),
              ),
            ),
          ],
        ),
      );
}
