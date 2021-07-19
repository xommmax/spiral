import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_viewmodel.dart';

class HubView extends StandardBaseView<HubViewModel> {
  HubView({
    required Hub hub,
    required User user,
  }) : super(HubViewModel(
          hub: hub,
          user: user,
        ));

  @override
  Widget getContent(BuildContext context) => WidgetHubViewContent();
}
