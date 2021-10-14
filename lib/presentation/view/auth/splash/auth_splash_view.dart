import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/auth/splash/auth_splash_view_content.dart';
import 'package:dairo/presentation/view/auth/splash/auth_splash_viewmodel.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/widgets.dart';

class AuthSplashView extends StandardBaseView<AuthSplashViewModel> {
  AuthSplashView()
      : super(AuthSplashViewModel(), routeName: Routes.authSplashView);

  @override
  Widget getContent(BuildContext context) => AuthSplashViewContent();
}
