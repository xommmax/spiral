import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthSplashViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  void onGetStartedPressed() =>
      _navigationService.navigateTo(Routes.authMethodView);
}
