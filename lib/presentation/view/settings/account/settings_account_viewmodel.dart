import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsAccountViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  void onLogoutClicked() => AppDialog.showConfirmationDialog(
        title: Strings.logout,
        description: Strings.confirmLogout,
        onConfirm: () async {
          await _userRepository.logoutUser();
          _navigationService.clearStackAndShow(Routes.authSplashView);
        },
      );
}
