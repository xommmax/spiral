import 'dart:async';

import 'package:country_codes/country_codes.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/method/auth_method_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthMethodViewModel extends BaseViewModel {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthViewData viewData = AuthViewData();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final TextEditingController phoneNumberController;
  late final StreamSubscription? authStateChangesSubscription;

  AuthMethodViewModel() {
    authStateChangesSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) _navigateMain();
    });
    phoneNumberController = TextEditingController(
        text: CountryCodes.dialCode(CountryCodes.getDeviceLocale())
                ?.replaceFirst('+', '') ??
            '1');
  }

  onGoogleSignUpClicked() =>
      _loginWithSocial(SocialAuthRequest(SocialAuthType.Google));

  onAppleSignUpClicked() =>
      _loginWithSocial(SocialAuthRequest(SocialAuthType.Apple));

  void _loginWithSocial(SocialAuthRequest request) {
    _userRepository.loginWithSocial(request).then(
          (result) => _navigateMain(),
        );
  }

  onPhoneNextClicked() async {
    String number = phoneNumberController.text;
    if (number.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.errorPhoneNumberIsEmpty);
      return;
    }
    if (number.length > 14 || number.length < 8) {
      AppSnackBar.showSnackBarError(Strings.errorInvalidPhoneNumber);
      return;
    }
    setBusy(true);
    await _userRepository.registerWithPhone('+' + number);
    setBusy(false);

    viewData.isCodeSent = true;
    notifyListeners();
  }

  onCodeVerificationRetrieved(String code) =>
      _userRepository.verifySmsCode(code).then((result) => _navigateMain());

  void _navigate
  // void _navigateMain() => _navigationService.clearStackAndShow(Routes.mainView);

  @override
  void dispose() {
    phoneNumberController.dispose();
    authStateChangesSubscription?.cancel();
    super.dispose();
  }
}
