import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/account/settings_account_view_content.dart';
import 'package:dairo/presentation/view/settings/account/settings_account_viewmodel.dart';
import 'package:flutter/widgets.dart';

class SettingsAccountView extends StandardBaseView<SettingsAccountViewModel> {
  @override
  Widget getContent(BuildContext context) => SettingsAccountViewContent();

  SettingsAccountView()
      : super(SettingsAccountViewModel(),
            routeName: Routes.settingsAccountView);
}
