import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ExploreViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  onSearchPressed() => _navigationService.navigateTo(Routes.searchView);
}
