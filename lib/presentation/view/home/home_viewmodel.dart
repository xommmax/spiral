import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends MultipleStreamViewModel {
  static const String USER_STREAM_KEY = 'USER_STREAM_KEY';
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();

  User? user;

  onAccountIconClicked() async {
    if (_userRepository.isCurrentUserExist()) {
      _navigationService.navigateTo(Routes.currentUserProfileView);
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result) {
          notifySourceChanged(clearOldData: true);
          initialise();
          _navigationService.navigateTo(Routes.currentUserProfileView);
        }
      });
    }
  }

  @override
  Map<String, StreamData> get streamsMap => _userRepository.isCurrentUserExist()
      ? {
          USER_STREAM_KEY: StreamData<User?>(
            userStream(),
            onData: _onUserData,
          ),
        }
      : {};

  Stream<User?> userStream() => _userRepository.getCurrentUser();

  _onUserData(User? data) => user = data;
}
