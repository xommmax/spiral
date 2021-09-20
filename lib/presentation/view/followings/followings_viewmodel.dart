import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowingsViewModel extends StreamViewModel<List<Hub>> {
  final List<String> hubIds;

  FollowingsViewModel({
    required this.hubIds,
  });

  final HubRepository _hubRepository = locator<HubRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Stream<List<Hub>> get stream => _hubRepository.getHubsByIds(hubIds);

  void onOpenHubDetailsClicked(Hub hub) => _navigationService.navigateTo(
        Routes.hubView,
        arguments: HubViewArguments(hubId: hub.id, userId: hub.userId),
      );

  @override
  void onError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetFollowingsList);
    super.onError(error);
  }
}
