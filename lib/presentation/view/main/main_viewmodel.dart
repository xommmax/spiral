import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  onFabPressed() {
    _navigationService.navigateTo(Routes.newPublicationView);
  }
}
