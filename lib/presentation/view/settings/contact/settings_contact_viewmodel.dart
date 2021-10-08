import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsContactViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void onSupportItemClicked() {
    _navigationService.navigateTo(Routes.supportView)?.then((result) {
      if (result != null && result is bool && result) {
        AppSnackBar.showSnackBarSuccess(Strings.supportRequestSuccessfullySent);
      }
    });
  }

  void onReportBugItemClicked() {}

  void onImprovementItemClicked() {}
}
