import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileSettingsViewModel extends BaseViewModel {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  void onLogoutClicked() => AppDialog.showConfirmationDialog(
        title: Strings.logout,
        description: Strings.confirmLogout,
        onConfirm: () async {
          await _userRepository.logoutUser();
          _navigationService.clearStackAndShow(Routes.authView);
        },
      );

  void onContactItemClicked() =>
      _navigationService.navigateTo(Routes.settingsContactView);

  void onBlockedUsersItemClicked() {}

  void onAccountItemClicked() {}
}
