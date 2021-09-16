import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_viewmodel.dart';

class HubView extends StandardBaseView<HubViewModel> {
  HubView({
    required String hubId,
    String? userId,
  }) : super(
          HubViewModel(
            hubId: hubId,
            userId: userId,
          ),
    routeName: Routes.hubView,
  );

  @override
  Widget getContent(BuildContext context) => WidgetHubViewContent();
}
