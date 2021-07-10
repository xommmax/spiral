import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends MultipleStreamViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();

  User? user;

  showAccountPage() async {
    bool isCurrentUserExists = await _userRepository.isCurrentUserExist();
    if (isCurrentUserExists) {
      _navigationService.navigateTo(Routes.currentUserProfileView);
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result) {
          _navigationService.navigateTo(Routes.currentUserProfileView);
        }
      });
    }
  }

  @override
  Map<String, StreamData> get streamsMap => {
        // _UserStreamKey: StreamData<User?>(userStream(), onData: _onUserData),
      };

  // Stream<User?> userStream() => _userRepository.getCurrentUserStream();

  _onUserData(User? data) => user = data;

  String? getPhotoUrl() => _userRepository.getCurrentUserPhotoUrl();
}

const String _UserStreamKey = 'userStream';
