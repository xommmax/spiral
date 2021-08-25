import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_base_profile_view.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetCurrentUserProfileViewContent
    extends ViewModelWidget<CurrentUserProfileViewModel> {
  @override
  Widget build(BuildContext context, CurrentUserProfileViewModel viewModel) =>
      Scaffold(
        appBar: viewModel.viewData.user != null
            ? AppBar(
                actions: [
                  IconButton(
                    onPressed: viewModel.onSettingsClicked,
                    icon: Icon(
                      Icons.settings,
                      color: AppColors.white,
                    ),
                  ),
                ],
              )
            : null,
        body: SafeArea(
          child: WidgetBaseProfileView<CurrentUserProfileViewModel>(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.onCreateHubClicked,
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
        ),
      );
}
