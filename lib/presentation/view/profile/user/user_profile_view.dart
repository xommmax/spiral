import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/profile/user/user_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/user/widgets/widget_user_profile_view_content.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StandardBaseView<UserProfileViewModel> {
  UserProfileView({required String userId})
      : super(UserProfileViewModel(userId),
    routeName: Routes.userProfileView,
  );

  @override
  Widget getContent(BuildContext context) => WidgetUserProfileViewContent();
}
