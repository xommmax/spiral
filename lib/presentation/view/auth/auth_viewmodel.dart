import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthViewData viewData = AuthViewData();
  final TextEditingController phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? authStateChangesSubscription;

  AuthViewModel() {
    authStateChangesSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) _navigateMain();
    });
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

  onCountryCodeChanged(String? countryCode) => viewData.phoneCode = countryCode;

  onPhoneSignUpClicked() async {
    if (viewData.phoneCode?.isEmpty ?? true) {
      AppSnackBar.showSnackBarError(Strings.errorUnableToGetPhoneCountryCode);
      return;
    }
    String number = phoneNumberController.text;
    if (number.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.errorPhoneNumberIsEmpty);
      return;
    }
    if (number.length > 14 || number.length < 8) {
      AppSnackBar.showSnackBarError(Strings.errorInvalidPhoneNumber);
      return;
    }
    String fullNumber = viewData.phoneCode! + number;

    setBusy(true);
    await _userRepository.registerWithPhone(fullNumber);
    setBusy(false);

    viewData.isCodeSent = true;
    notifyListeners();
  }

  onCodeVerificationRetrieved(String code) =>
      _userRepository.verifySmsCode(code).then((result) => _navigateMain());

  void _navigateMain() => _navigationService.clearStackAndShow(Routes.mainView);

  @override
  void dispose() {
    phoneNumberController.dispose();
    authStateChangesSubscription?.cancel();
    super.dispose();
  }
}
