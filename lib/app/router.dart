import 'package:dairo/presentation/view/auth/auth_view.dart';
import 'package:dairo/presentation/view/hub/hub_view.dart';
import 'package:dairo/presentation/view/main/main_view.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_view.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_view.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: AuthView),
    MaterialRoute(page: MainView, initial: true),
    MaterialRoute(page: NewPublicationView),
    MaterialRoute(page: CurrentUserProfileView),
    MaterialRoute(page: NewHubView),
    MaterialRoute(page: HubView),
  ],
)
class $AppRouter {}
