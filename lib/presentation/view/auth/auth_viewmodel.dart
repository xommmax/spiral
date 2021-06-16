import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        FirebaseAuth,
        FirebaseAuthException,
        PhoneAuthCredential,
        PhoneAuthProvider;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends StreamViewModel<User?> {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  final AuthViewData viewData = AuthViewData();

  @override
  void initialise() {
    _listenUserChanges();
    super.initialise();
  }

  Future<void> _sendVerificationCode(PhoneAuthCredential credential) =>
      _firebaseAuth.signInWithCredential(credential).catchError((error) {
        AppSnackBar.showSnackBarError(Strings.wrongVerificationCode);
      });

  Future<void> _verifyPhoneNumber(String number) =>
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) {
          setBusy(false);
          _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setBusy(false);
          AppSnackBar.showSnackBarError(
              Strings.errorWhilePhoneNumberVerification);
        },
        codeSent: (String verificationId, int? resendToken) {
          setBusy(false);
          viewData.verificationId = verificationId;
          viewData.isCodeSent = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setBusy(false);
          viewData.verificationId = verificationId;
        },
      );

  StreamSubscription? _firebaseUserChangedSubscription;

  _listenUserChanges() {
    _firebaseUserChangedSubscription =
        _firebaseAuth.userChanges().listen((user) {
      if (user != null && !user.isAnonymous) {
        User domainUser = User(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
        );
        _userRepository.updateUser(domainUser);
      }
    });
  }

  @override
  Stream<User?> get stream => _userRepository.getUserStream().map(
        (event) => event.getException != null
            ? AppSnackBar.showSnackBarError(Strings.unableToGetCurrentUser)
            : event.data,
      );

  @override
  void onData(User? data) async {
    if (data != null) {
      AppSnackBar.showSnackBarSuccess('User successfully retrieved');
      await Future.delayed(Duration(seconds: 1));
      _navigationService.clearStackAndShow(Routes.splashView);
    }
    super.onData(data);
  }

  onCountryCodeChanged(String? countryCode) => viewData.phoneCode = countryCode;

  void onSignUpClicked() async {
    if (viewData.phoneCode?.isEmpty ?? true) {
      AppSnackBar.showSnackBarError(Strings.unableToGetPhoneCountryCode);
      return;
    }
    String number = viewData.phoneNumberController.text;
    if (number.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.phoneNumberIsEmpty);
      return;
    }
    if (number.length > 14 || number.length < 8) {
      AppSnackBar.showSnackBarError(Strings.invalidPhoneNumber);
      return;
    }
    String fullNumber = viewData.phoneCode! + number;
    setBusy(true);
    await _verifyPhoneNumber(fullNumber);
  }

  void onCodeVerificationRetrieved(String code) {
    if (viewData.verificationId != null) {
      _sendVerificationCode(
        PhoneAuthProvider.credential(
          verificationId: viewData.verificationId!,
          smsCode: code,
        ),
      );
    }
  }

  @override
  void dispose() {
    _firebaseUserChangedSubscription?.cancel();
    super.dispose();
  }
}
