import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_viewmodel.dart';

class HubView extends StandardBaseView<HubViewModel> {
  HubView({
    required String hubId,
    required String userId,
    bool onboarding = false,
  }) : super(
          HubViewModel(
            hubId: hubId,
            userId: userId,
            onboarding: onboarding,
          ),
          routeName: Routes.hubView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetHubViewContent();
}
