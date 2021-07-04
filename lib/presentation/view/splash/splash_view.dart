import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/splash/splash_viewmodel.dart';
import 'package:dairo/presentation/view/splash/widgets/splash_view_content.dart';
import 'package:flutter/widgets.dart';

class SplashView extends StandardBaseView<SplashViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetSplashViewContent();

  @override
  getViewModel() => SplashViewModel();
}
