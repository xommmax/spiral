import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/settings/settings_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsViewModel() {
    initUser();
  }

  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final SettingsViewData viewData = SettingsViewData();

  Future<void> initUser() async {
    viewData.user = await _userRepository.getCurrentUser().first;
    notifyListeners();
  }

  void onLogoutClicked() => AppDialog.showConfirmationDialog(
        title: Strings.areYouSureYouWantToLogout,
        onConfirm: (isConfirm) async {
          if (isConfirm) {
            await _userRepository.logoutUser();
            _navigateToHomeScreen();
          }
        },
      );

  void onItemClicked(int index) {
    switch (index) {
      case 0:
        return _navigateToAccountDetailsScreen();
      case 1:
        return _navigateToSupportScreen();
    }
  }

  void _navigateToAccountDetailsScreen() =>
      _navigationService.navigateTo(Routes.accountDetailsView);

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
