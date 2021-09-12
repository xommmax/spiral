import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class BaseProfileViewModel extends MultipleStreamViewModel {
  static const String USER_STREAM_KEY = 'USER_STREAM_KEY';
  static const String HUB_LIST_STREAM_KEY = 'HUB_LIST_STREAM_KEY';

  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository userRepository = locator<UserRepository>();
  final HubRepository hubRepository = locator<HubRepository>();
  final BaseProfileViewData viewData = BaseProfileViewData();

  @override
  Map<String, StreamData> get streamsMap => {
        USER_STREAM_KEY: StreamData<User?>(
          userStream(),
          onData: onUserData,
          onError: onUserError,
        ),
        HUB_LIST_STREAM_KEY: StreamData<List<Hub>>(
          hubListStream(),
          onData: obHubsData,
          onError: onHubsError,
        ),
      };

  Stream<User?> userStream();

  Stream<List<Hub>> hubListStream();

  void onUserData(User? data) => viewData.user = data;

  void obHubsData(List<Hub> data) => viewData.hubs = data;

  void onUserError(error) {
    AppSnackBar.showSnackBarError(Strings.errorUnableToGetCurrentUser);
  }

  void onHubsError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetHubsList);
  }

  void onOpenHubClicked(Hub hub) {
    if (hub.isPrivate && hub.userId != userRepository.getCurrentUserId())
      return;
    _navigationService.navigateTo(
      Routes.hubView,
      arguments: HubViewArguments(
        hubId: hub.id,
        userId: viewData.user!.id,
      ),
    );
  }

  void onSettingsClicked() {
    if (viewData.user != null)
      _navigationService.navigateTo(Routes.settingsView);
  }

  void onUserHubsFollowingClicked() async {
    if (viewData.user == null || viewData.user!.followingsCount! <= 0) return;
    List<String> userIds =
        await hubRepository.getUserFollowsHubsIds(viewData.user!.id);
    _navigationService.navigateTo(
      Routes.hubsView,
      arguments: HubsViewArguments(userIds: userIds),
    );
  }

  String? getPhotoUrl() => viewData.user?.photoURL;
}
