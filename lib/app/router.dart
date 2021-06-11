import 'package:dairo/presentation/view/auth/auth_view.dart';
import 'package:dairo/presentation/view/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: AuthView),
  ],
)
class $AppRouter {}
