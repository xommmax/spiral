import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hubs/widgets/widget_hubs_view_content.dart';
import 'package:flutter/widgets.dart';

import 'hubs_viewmodel.dart';

class HubsView extends StandardBaseView<HubsViewModel> {
  HubsView({
    required List<String> userIds,
  }) : super(
          HubsViewModel(
            hubIds: userIds,
          ),
        );

  @override
  Widget getContent(BuildContext context) => WidgetHubsViewContent();
}
