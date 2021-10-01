import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/settings/settings_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileSettingsViewModel extends BaseViewModel {
  ProfileSettingsViewModel() {
    initUser();
  }

  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final ProfileSettingsViewData viewData = ProfileSettingsViewData();

  Future<void> initUser() async {
    viewData.user = await _userRepository.getCurrentUser().first;
    notifyListeners();
  }

  void onLogoutClicked() => AppDialog.showConfirmationDialog(
        title: Strings.logout,
        description: Strings.confirmLogout,
        onConfirm: () async {
          await _userRepository.logoutUser();
          _navigateToHomeScreen();
        },
      );

  void onItemClicked(int index) {
    switch (index) {
      case 0:
        _navigateToSupportScreen();
        return;
      case 2:
        onLogoutClicked();
        return;
    }
  }

  void _navigateToSupportScreen() =>
      _navigationService.navigateTo(Routes.supportView)?.then((result) {
        if (result != null && result is bool && result) {
          AppSnackBar.showSnackBarSuccess(
              Strings.supportRequestSuccessfullySent);
        }
      });

  void _navigateToHomeScreen() =>
      _navigationService.clearStackAndShow(Routes.mainView);
}
