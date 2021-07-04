import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/creation/widgets/widget_hub_creation_view_content.dart';
import 'package:flutter/material.dart';

import 'hub_creation_viewmodel.dart';

class HubCreationView extends StandardBaseView<HubCreationViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetHubCreationViewContent();

  @override
  getViewModel() => HubCreationViewModel();
}
