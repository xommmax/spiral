import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettingsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void onContactItemClicked() =>
      _navigationService.navigateTo(Routes.settingsContactView);

  void onBlockedUsersItemClicked() {}

  void onAccountItemClicked() =>
      _navigationService.navigateTo(Routes.settingsAccountView);

  void onTermsClicked() => launch(Strings.termsUrl);

  void onPrivacyClicked() => launch(Strings.privacyUrl);
}
