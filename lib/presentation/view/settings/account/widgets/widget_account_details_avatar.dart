import 'dart:io';

import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:dairo/presentation/view/settings/account/account_details_viewmodel.dart';
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
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: viewModel.viewData.photoUrl == null
              ? WidgetProfilePhoto(
                  width: 90,
                  height: 90,
                  photoUrl: viewModel.data?.photoURL,
                )
              : CircleAvatar(
                  radius: 40,
                  foregroundImage: Image.file(
                    File(viewModel.viewData.photoUrl!),
                    fit: BoxFit.fitWidth,
                  ).image,
                  backgroundColor: Colors.transparent,
                ),
        ),
      );
}
