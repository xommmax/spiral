import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/page/widgets/widget_hub_page_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_page_viewmodel.dart';

class HubView extends StandardBaseView<HubViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetHubViewContent();

  @override
  getViewModel() => HubViewModel();
}
