import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/splash/splash_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends FutureViewModel<SplashViewData> {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();

  @override
  Future<SplashViewData> futureToRun() async {
    SplashViewData viewData = SplashViewData();
    viewData.user = await _getUser();
    return viewData;
  }

  Future<User?> _getUser() =>
      _userRepository.getUser().then((result) => result.getException != null
          ? AppSnackBar.showSnackBarError(Strings.unableToGetCurrentUser)
          : result.data);

  @override
  void onData(SplashViewData? data) {
    if (data?.user == null) {
      _navigateToAuthScreen();
    }
    super.onData(data);
  }

  @override
  void onError(error) {
    print(error);
    AppSnackBar.showSnackBarError(Strings.somethingWentWrong);
  }

  onResetUserClicked() async {
    await _firebaseAuth.signOut();
    _userRepository.deleteUser();
    initialise();
  }

  _navigateToAuthScreen() {
    _navigationService.clearStackAndShow(Routes.authView);
  }
}
