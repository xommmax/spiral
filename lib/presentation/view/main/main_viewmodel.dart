import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  showAccountPage() {
    if (_isUserExist()) {
      _navigationService.navigateTo(Routes.accountView);
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result && _isUserExist()) {
          _navigationService.navigateTo(Routes.accountView);
        }
      });
    }
  }

  onFabPressed() {
    if (_isUserExist()) {
      _navigationService.navigateTo(Routes.newPublicationView);
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result && _isUserExist()) {
          _navigationService.navigateTo(Routes.newPublicationView, arguments: NewPublicationViewArguments(hubId: '1'));
        }
      });
    }
  }

  bool _isUserExist() => FirebaseAuth.instance.currentUser?.uid != null;
}
