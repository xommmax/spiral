import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_page_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_viewmodel.dart';

class HubView extends StandardBaseView<HubViewModel> {
  final String hubId;

  HubView({
    required this.hubId,
  });

  @override
  Widget getContent(BuildContext context) => WidgetHubViewContent();

  @override
  getViewModel() => HubViewModel(hubId: hubId);
}
