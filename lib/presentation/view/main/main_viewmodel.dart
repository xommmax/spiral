import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  showAccountPage() {
    _navigationService.navigateTo(Routes.accountView);
  }

  onFabPressed() {
    _navigationService.navigateTo(Routes.newPublicationView);
  }
}
