import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked_services/stacked_services.dart';

class CurrentUserProfileViewModel extends BaseProfileViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Stream<User?> userStream() => userRepository.getCurrentUser();

  @override
  Stream<List<Hub>> hubListStream() => hubRepository.getCurrentUserHubs();

  onCreateHubClicked() => _navigationService.navigateTo(Routes.newHubView);

  void onEditProfileClicked() {
    _navigationService.navigateTo(Routes.accountDetailsView)?.then((result) {
      if (result != null && result is bool && result) {
        AppSnackBar.showSnackBarSuccess(Strings.accountUpdatedSuccessfully);
      }
    });
  }
}
