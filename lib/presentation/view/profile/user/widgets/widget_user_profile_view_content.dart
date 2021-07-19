import 'package:dairo/presentation/view/profile/base/widgets/widget_base_profile_view.dart';
import 'package:dairo/presentation/view/profile/user/user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetUserProfileViewContent
    extends ViewModelWidget<UserProfileViewModel> {
  @override
  Widget build(BuildContext context, UserProfileViewModel viewModel) =>
      Scaffold(
        body: SafeArea(
          child: WidgetBaseProfileView<UserProfileViewModel>(),
        ),
      );
}
