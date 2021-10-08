import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/settings_viewmodel.dart';
import 'package:dairo/presentation/view/settings/widgets/settings_view_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileSettingsView extends StandardBaseView<ProfileSettingsViewModel> {
  ProfileSettingsView()
      : super(
          ProfileSettingsViewModel(),
          routeName: Routes.profileSettingsView,
        );

  @override
  Widget getContent(BuildContext context) => ProfileSettingsViewContent();
}
