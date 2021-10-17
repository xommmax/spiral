import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthSplashViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  UserRepository _userRepository = locator<UserRepository>();

  AuthSplashViewModel() {
    checkCurrentUserState();
  }

  void checkCurrentUserState() async {
    bool isFirebaseUserExist = _auth.currentUser != null;
    if (!isFirebaseUserExist) return;
    bool isDatabaseUserExist =
        await _userRepository.isFirebaseUserExist(_auth.currentUser!);
    if (isFirebaseUserExist && !isDatabaseUserExist) {
      _userRepository.logoutUser();
    }
  }

  void onGetStartedPressed() =>
      _navigationService.replaceWith(Routes.authMethodView);
}
