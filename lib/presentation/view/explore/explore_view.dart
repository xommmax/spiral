import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_explore_view_content.dart';
import 'package:flutter/widgets.dart';

import 'explore_viewmodel.dart';

class ExploreView extends StandardBaseView<ExploreViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetExploreViewContent();

  @override
  getViewModel() => ExploreViewModel();
}
