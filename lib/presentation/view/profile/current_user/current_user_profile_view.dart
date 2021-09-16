import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/current_user/widgets/widget_current_user_profile_view_content.dart';
import 'package:flutter/material.dart';

class CurrentUserProfileView
    extends StandardBaseView<CurrentUserProfileViewModel> {
  CurrentUserProfileView() : super(CurrentUserProfileViewModel(),
    routeName: Routes.currentUserProfileView,
  );

  @override
  Widget getContent(BuildContext context) =>
      WidgetCurrentUserProfileViewContent();
}
