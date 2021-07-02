import 'package:dairo/presentation/view/auth/auth_view.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_view.dart';
import 'package:dairo/presentation/view/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: NewPublicationView, initial: true),
  ],
)
class $AppRouter {}
