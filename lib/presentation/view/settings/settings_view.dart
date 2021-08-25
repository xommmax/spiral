import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/settings_viewmodel.dart';
import 'package:dairo/presentation/view/settings/widgets/widget_settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsView extends StandardBaseView<SettingsViewModel> {
  SettingsView()
      : super(
          SettingsViewModel(),
        );

  @override
  Widget getContent(BuildContext context) => WidgetSettingsContent();
}
