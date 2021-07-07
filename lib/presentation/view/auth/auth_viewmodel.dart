import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/user/social_auth_exception.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends StreamViewModel<User?> {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthViewData viewData = AuthViewData();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initialise() {
    _userRepository.subscribeToFirebaseUserChanges();
    super.initialise();
  }

  @override
  Stream<User?> get stream => _userRepository.getUserStream().map(
        (event) => event.getException != null
            ? AppSnackBar.showSnackBarError(Strings.errorUnableToGetCurrentUser)
            : event.data,
      );

  @override
  void onData(User? data) async {
    if (data != null) {
      _navigationService.back(result: true);
    }
    super.onData(data);
  }

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
    await _onTryToRegisterCalled(
            SocialAuthRequest(data: fullNumber, type: SocialAuthType.Phone))
        .then(
      (_) {
        viewData.isCodeSent = true;
        notifyListeners();
      },
    );
  }

  onGoogleSignUpClicked() =>
      _onTryToRegisterCalled(SocialAuthRequest(type: SocialAuthType.Google));

  onFacebookSignUpClocked() =>
      _onTryToRegisterCalled(SocialAuthRequest(type: SocialAuthType.Facebook));

  onAppleSignUpClicked() =>
      _onTryToRegisterCalled(SocialAuthRequest(type: SocialAuthType.Apple));

  onCountryCodeChanged(String? countryCode) => viewData.phoneCode = countryCode;

  onCodeVerificationRetrieved(String code) {
    try {
      _userRepository.onVerificationCodeProvided(code);
    } catch (e) {
      if (e is SocialAuthException) {
        AppSnackBar.showSnackBarError(e.message);
      } else {
        AppSnackBar.showSnackBarError(Strings.errorSomethingWentWrong);
      }
    }
  }

  Future<void> _onTryToRegisterCalled(SocialAuthRequest request) async {
    if (request.type == SocialAuthType.Phone) {
      setBusy(true);
    }
    try {
      await _userRepository.tryToRegister(
        request,
      );
    } catch (e) {
      if (e is SocialAuthException) {
        AppSnackBar.showSnackBarError(e.message);
      } else {
        AppSnackBar.showSnackBarError(Strings.errorSomethingWentWrong);
      }
    }
    setBusy(false);
  }

  @override
  void dispose() {
    _userRepository.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
