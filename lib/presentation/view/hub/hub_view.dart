import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_viewmodel.dart';

class HubView extends StandardBaseView<HubViewModel> {
  final Hub hub;
  final User user;

  HubView({
    required this.hub,
    required this.user,
  });

  @override
  Widget getContent(BuildContext context) => WidgetHubViewContent();

  @override
  getViewModel() => HubViewModel(
        hub: hub,
        user: user,
      );
}
