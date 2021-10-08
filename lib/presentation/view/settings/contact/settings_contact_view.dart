import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/contact/settings_contact_view_content.dart';
import 'package:dairo/presentation/view/settings/contact/settings_contact_viewmodel.dart';
import 'package:flutter/widgets.dart';

class SettingsContactView extends StandardBaseView<SettingsContactViewModel> {
  SettingsContactView()
      : super(SettingsContactViewModel(),
            routeName: Routes.settingsContactView);

  @override
  Widget getContent(BuildContext context) => SettingsContactViewContent();
}
