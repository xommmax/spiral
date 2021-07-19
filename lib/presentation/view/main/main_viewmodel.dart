import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();

  onFabPressed() async {
    if (_userRepository.isCurrentUserExist()) {
      _navigationService.navigateTo(Routes.newPublicationView,
          arguments: NewPublicationViewArguments(hubId: '1'));
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result) {
          _navigationService.navigateTo(Routes.newPublicationView,
              arguments: NewPublicationViewArguments(hubId: '1'));
        }
      });
    }
  }
}
