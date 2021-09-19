import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/settings/hub_settings_viewmodel.dart';
import 'package:dairo/presentation/view/hub/settings/widgets/widget_hub_settings_view_content.dart';
import 'package:flutter/widgets.dart';

class HubSettingsView extends StandardBaseView<HubSettingsViewModel> {
  HubSettingsView(Hub hub)
      : super(
          HubSettingsViewModel(hub),
          routeName: Routes.hubSettingsView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetHubSettingsContent();
}
