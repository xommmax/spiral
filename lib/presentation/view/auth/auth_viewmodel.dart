import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/user/social_auth_exception.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthViewData viewData = AuthViewData();
  final TextEditingController phoneNumberController = TextEditingController();

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

  onCodeVerificationRetrieved(String code) async {
    try {
      final result = await _userRepository.onVerificationCodeProvided(code);
      if (result != null) {
        _navigationService.back(result: true);
      }
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
      final result = await _userRepository.register(
        request,
      );

      if (result != null) {
        _navigationService.back(result: true);
      }
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
    phoneNumberController.dispose();
    super.dispose();
  }
}
