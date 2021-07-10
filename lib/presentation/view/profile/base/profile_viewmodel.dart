import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/profile_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends MultipleStreamViewModel {
  static const String USER_STREAM_KEY = '_USER_STREAM_KEY';
  static const String HUB_LIST_STREAM_KEY = '_HUB_LIST_STREAM_KEY';

  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();
  final ProfileViewData viewData = ProfileViewData();

  @override
  void initialise() {
    _hubRepository.refreshHubs();
    super.initialise();
  }

  @override
  Map<String, StreamData> get streamsMap => {
        USER_STREAM_KEY: StreamData<User?>(
          userStream(),
          onData: _onUserData,
          onError: _onUserError,
        ),
        HUB_LIST_STREAM_KEY: StreamData<List<Hub>>(
          hubListStream(),
          onData: _obHubListData,
          onError: _onHubListError,
        ),
      };

  Stream<User?> userStream() => _userRepository.getCurrentUserStream();

  Stream<List<Hub>> hubListStream() => _hubRepository.getUserHubsStream();

  void _onUserData(User? data) => viewData.user = data;

  void _obHubListData(List<Hub> data) => viewData.hubList = data;

  void _onUserError(error) {
    AppSnackBar.showSnackBarError(Strings.errorUnableToGetCurrentUser);
  }

  void _onHubListError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetHubsList);
  }

  void onCreateHubClicked() =>
      _navigationService.navigateTo(Routes.hubCreationView);

  void onHubClicked(String? hubId) {
    if (hubId == null) {
      AppSnackBar.showSnackBarError(Strings.cannotOpenHubPleaseContactUs);
      return;
    }
    _navigationService.navigateTo(
      Routes.hubView,
      arguments: HubViewArguments(hubId: hubId),
    );
  }

  void onSettingsClicked() {}
}
