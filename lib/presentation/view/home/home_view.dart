import 'package:dairo/app/locator.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/home/widgets/widget_home_view_content.dart';
import 'package:flutter/widgets.dart';

import 'home_viewmodel.dart';

class HomeView extends StandardBaseView<HomeViewModel> {
  HomeView()
      : super(locator<HomeViewModel>(),
            routeName: '/home', disposeViewModel: false);

  @override
  Widget getContent(BuildContext context) => WidgetHomeViewContent();
}
