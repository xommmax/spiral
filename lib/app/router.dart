import 'package:dairo/presentation/view/auth/auth_view.dart';
import 'package:dairo/presentation/view/hub/hub_view.dart';
import 'package:dairo/presentation/view/main/main_view.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_view.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_view.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_view.dart';
import 'package:dairo/presentation/view/profile/user/user_profile_view.dart';
import 'package:dairo/presentation/view/publication/publication_view.dart';
import 'package:dairo/presentation/view/users/users_view.dart';
import 'package:dairo/presentation/view/search/search_view.dart';
import 'package:dairo/presentation/view/settings/account/account_details_view.dart';
import 'package:dairo/presentation/view/settings/settings_view.dart';
import 'package:dairo/presentation/view/settings/support/support_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: AuthView),
    MaterialRoute(page: MainView, initial: true),
    MaterialRoute(page: NewPublicationView),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: CurrentUserProfileView),
    MaterialRoute(page: NewHubView),
    MaterialRoute(page: HubView),
    MaterialRoute(page: UsersView),
    MaterialRoute(page: PublicationView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: AccountDetailsView),
    MaterialRoute(page: SupportView),
  ],
)
class $AppRouter {}
