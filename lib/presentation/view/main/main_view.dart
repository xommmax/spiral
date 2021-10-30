import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/widgets.dart';

import 'main_viewmodel.dart';
import 'widgets/widget_main_view_content.dart';

class MainView extends StandardBaseView<MainViewModel> {
  MainView()
      : super(
          locator<MainViewModel>(),
          routeName: Routes.mainView,
          disposeViewModel: false,
        );

  @override
  Widget getContent(BuildContext context) => WidgetMainViewContent();
}
