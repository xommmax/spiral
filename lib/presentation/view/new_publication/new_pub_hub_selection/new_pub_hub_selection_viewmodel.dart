import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewPubHubSelectionViewModel extends StreamViewModel<List<Hub>> {
  final NavigationService _navigationService = locator<NavigationService>();
  final HubRepository _hubRepository = locator<HubRepository>();

  void onHubSelected(String hubId) => _navigationService.replaceWith(
        Routes.newPublicationView,
        arguments: NewPublicationViewArguments(hubId: hubId),
      );

  @override
  Stream<List<Hub>> get stream => _hubRepository.getCurrentUserHubs();

  void onCreateHub() {
    _navigationService.navigateTo(Routes.newHubView)?.then((result) {
      if (result != null && result is String) {
        onHubSelected(result);
      }
    });
  }
}
