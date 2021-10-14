import 'package:dairo/presentation/view/auth/method/auth_method_view.dart';
import 'package:dairo/presentation/view/auth/splash/auth_splash_view.dart';
import 'package:dairo/presentation/view/followers/followers_view.dart';
import 'package:dairo/presentation/view/followings/followings_view.dart';
import 'package:dairo/presentation/view/hub/discussion/hub_discussion_view.dart';
import 'package:dairo/presentation/view/hub/hub_view.dart';
import 'package:dairo/presentation/view/hub/settings/hub_settings_view.dart';
import 'package:dairo/presentation/view/main/main_view.dart';
import 'package:dairo/presentation/view/messaging/messaging_view.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_view.dart';
import 'package:dairo/presentation/view/new_publication/new_pub_hub_selection/new_pub_hub_selection_view.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_view.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_view.dart';
import 'package:dairo/presentation/view/profile/user/user_profile_view.dart';
import 'package:dairo/presentation/view/publication/publication_view.dart';
import 'package:dairo/presentation/view/search/search_view.dart';
import 'package:dairo/presentation/view/settings/account/settings_account_view.dart';
import 'package:dairo/presentation/view/settings/contact/settings_contact_view.dart';
import 'package:dairo/presentation/view/settings/contact/suggestion/suggestion_view.dart';
import 'package:dairo/presentation/view/settings/contact/support/support_view.dart';
import 'package:dairo/presentation/view/settings/edit_account/account_details_view.dart';
import 'package:dairo/presentation/view/settings/settings_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: AuthSplashView),
    MaterialRoute(page: AuthMethodView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: NewPublicationView),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: CurrentUserProfileView),
    MaterialRoute(page: NewHubView),
    MaterialRoute(page: HubView),
    MaterialRoute(page: FollowersView),
    MaterialRoute(page: PublicationView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: ProfileSettingsView),
    MaterialRoute(page: AccountDetailsView),
    MaterialRoute(page: SupportView),
    MaterialRoute(page: FollowingsView),
    MaterialRoute(page: HubSettingsView),
    MaterialRoute(page: NewPubHubSelectionView),
    MaterialRoute(page: HubDiscussionView),
    MaterialRoute(page: SettingsContactView),
    MaterialRoute(page: SuggestionView),
    MaterialRoute(page: SettingsAccountView),
    MaterialRoute(page: MessagingView),
  ],
)
class $AppRouter {}
