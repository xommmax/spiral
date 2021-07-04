import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  createHub() => _navigationService.navigateTo(Routes.hubCreationView);
}
