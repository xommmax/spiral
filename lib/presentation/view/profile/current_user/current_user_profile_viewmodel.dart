import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class CurrentUserProfileViewModel extends BaseProfileViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  onCreateHubClicked() => _navigationService.navigateTo(Routes.newHubView);
}
