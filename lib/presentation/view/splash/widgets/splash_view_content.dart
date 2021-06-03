import 'package:dairo/presentation/view/splash/splash_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetSplashViewContent extends ViewModelWidget<SplashViewModel> {
  @override
  Widget build(BuildContext context, SplashViewModel viewModel) =>
      Container(
        child: Center(
          child: Text('Hello World!'),
        ),
      );
}
