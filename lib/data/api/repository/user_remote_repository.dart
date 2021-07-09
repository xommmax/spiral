import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dairo/data/api/model/request/user_request.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/domain/model/user/social_auth_exception.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@lazySingleton
class UserRemoteRepository {
  String? codeVerificationId;

  Future<UserResponse?> fetchUser(String userUid) => FirebaseFirestore.instance
      .doc('/users/$userUid')
      .get()
      .catchError((error) =>
          throw Exception('Error while getting user from Firestore: $error'))
      .then(
        (snapshot) => snapshot.exists && snapshot.data() != null
            ? UserResponse.fromJson(snapshot.id, snapshot.data()!)
            : null,
      );

  Future<void> updateUser(UserRequest request) => FirebaseFirestore.instance
      .collection('/users')
      .doc('${request.id}')
      .set(
        request.toJson(),
      )
      .catchError((error) =>
          throw Exception('Error while updating user from Firestore: $error'));

  Future register(SocialAuthRequest request) async {
    switch (request.type) {
      case SocialAuthType.Phone:
        return _onPhoneAuthRequested(request.data);

      case SocialAuthType.Google:
        return _onGoogleAuthRequested();

      case SocialAuthType.Apple:
        return _onAppleAuthRequested();

      case SocialAuthType.Facebook:
        return _onFacebookAuthRequested();
    }
  }

  Future<UserCredential> onVerificationCodeProvided(String code) {
    try {
      if (codeVerificationId == null) {
        throw SocialAuthException(
            message: Strings.errorVerificationCodeIsInvalid);
      }
      return _signInWithCredentials(
        PhoneAuthProvider.credential(
          verificationId: codeVerificationId!,
          smsCode: code,
        ),
      );
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      throw SocialAuthException(
          message: Strings.errorVerificationCodeIsInvalid);
    }
  }

  Future<UserCredential> _onGoogleAuthRequested() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null)
        throw Exception(Strings.errorUnableToFindGoogleUser);

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      return _signInWithCredentials(credential);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      throw SocialAuthException(message: Strings.errorGoogleAuthError);
    }
  }

  Future<UserCredential> _onFacebookAuthRequested() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final String? token = result.accessToken?.token;
        if (token == null)
          throw SocialAuthException(message: Strings.errorFacebookAuthError);
        final OAuthCredential credential =
            FacebookAuthProvider.credential(token);
        return _signInWithCredentials(credential);
      } else {
        throw SocialAuthException(
            message: Strings.errorUnableToGetCredentialsFromFacebook);
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      throw SocialAuthException(message: Strings.errorFacebookAuthError);
    }
  }

  Future<UserCredential> _onAppleAuthRequested() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      return _signInWithCredentials(oauthCredential);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      throw SocialAuthException(message: Strings.errorAppleAuthError);
    }
  }

  Future<void> _onPhoneAuthRequested(String? number) {
    if (number == null) {
      throw SocialAuthException(
        message: Strings.errorPhoneNumberIsEmpty,
      );
    }
    return FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) =>
          _signInWithCredentials(credential),
      verificationFailed: (FirebaseAuthException e) =>
          throw SocialAuthException(
        message:
            e.message != null ? e.message! : Strings.errorPhoneNumberAuthError,
      ),
      codeSent: (String verificationId, int? resendToken) =>
          codeVerificationId = verificationId,
      codeAutoRetrievalTimeout: (String verificationId) =>
          codeVerificationId = verificationId,
    );
  }

  Future<UserCredential> _signInWithCredentials(AuthCredential credentials) =>
      FirebaseAuth.instance.signInWithCredential(credentials);

  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
