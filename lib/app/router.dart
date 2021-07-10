import 'package:dairo/presentation/view/hub/hub_view.dart';
import 'package:dairo/presentation/view/profile/base/profile_view.dart';
import 'package:dairo/presentation/view/auth/auth_view.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_view.dart';
import 'package:dairo/presentation/view/main/main_view.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_view.dart';
import 'package:dairo/presentation/view/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: MainView, initial: true),
    MaterialRoute(page: NewPublicationView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: HubCreationView),
    MaterialRoute(page: HubView),
  ],
)
class $AppRouter {}
