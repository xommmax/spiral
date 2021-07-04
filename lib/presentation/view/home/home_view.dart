import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/home/widgets/widget_home_view_content.dart';
import 'package:flutter/widgets.dart';

import 'home_viewmodel.dart';

class HomeView extends StandardBaseView<HomeViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetHomeViewContent();

  @override
  getViewModel() => HomeViewModel();
}
