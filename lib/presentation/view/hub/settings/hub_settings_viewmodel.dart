import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/hub/settings/hub_settings_viewdata.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HubSettingsViewModel extends BaseViewModel {
  final HubRepository _hubRepository = locator<HubRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final HubSettingsViewData viewData;

  HubSettingsViewModel(Hub hub) : viewData = HubSettingsViewData(hub);

  void onPrivateHubSwitchChanged(bool value) =>
      _hubRepository.setHubPrivate(viewData.hub, value).then((value) {
        viewData.hub = value;
        notifyListeners();
      });

  void onDeleteHubClicked() {
    AppDialog.showConfirmationDialog(
      title: Strings.deleteHub,
      cancelText: Strings.no,
      confirmText: Strings.yes,
      onConfirm: _deleteHub,
    );
  }

  void _deleteHub(isConfirm) {
    if (!isConfirm) return;
    _hubRepository.deleteHub(viewData.hub);
    _navigationService.popUntil(
        (route) => route.settings.name == Routes.currentUserProfileView);
  }
}
