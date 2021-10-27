import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/helper.dart';
import 'package:dairo/data/api/model/request/user_request.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/domain/model/user/social_auth_exception.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@lazySingleton
class UserRemoteRepository {
  String? codeVerificationId;
  final ApiHelper apiHelper = locator<ApiHelper>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserResponse?> fetchUser(String userId) =>
      _firestore.collection(FirebaseCollections.users).doc(userId).get().then(
            (snapshot) => snapshot.exists
                ? UserResponse.fromJson(snapshot.data(), id: snapshot.id)
                : null,
          );

  Future<List<UserResponse>> fetchUsers(List<String> userIds) => Future.wait(
        userIds.map(
          (userId) => _firestore
              .collection(FirebaseCollections.users)
              .where(FieldPath.documentId, isEqualTo: userId)
              .get()
              .then(
                (snapshots) => UserResponse.fromJson(
                    snapshots.docs.first.data(),
                    id: snapshots.docs.first.id),
              ),
        ),
      );

  Future<UserResponse> saveFirebaseUser(UserRequest request) async {
    final reference =
        _firestore.collection(FirebaseCollections.users).doc(request.id);
    var snapshot = await reference.get();
    var requestJson = request.toJson();
    requestJson['followingsCount'] = snapshot.data()?['followingsCount'] ?? 0;
    if (snapshot.exists) {
      await reference.update(requestJson);
    } else {
      await reference.set(requestJson);
    }
    snapshot = await reference.get();
    return UserResponse.fromJson(snapshot.data(), id: snapshot.id);
  }

  Future<void> loginWithSocial(SocialAuthRequest request) async {
    switch (request.type) {
      case SocialAuthType.Google:
        await _loginWithGoogle();
        break;
      case SocialAuthType.Apple:
        await _loginWithApple();
        break;
      default:
        throw ArgumentError.value(request);
    }
  }

  Future<User> _loginWithGoogle() async {
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
  }

  Future<User> _loginWithApple() async {
    final rawNonce = apiHelper.generateNonce();
    final nonce = apiHelper.sha256ofString(rawNonce);

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
  }

  Future<User> _signInWithCredentials(AuthCredential credentials) =>
      FirebaseAuth.instance
          .signInWithCredential(credentials)
          .then((credential) => credential.user!);

  Future<void> registerWithPhone(String number) =>
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: _signInWithCredentials,
        verificationFailed: (e) =>
            throw SocialAuthException(message: e.message!),
        codeSent: (id, token) => codeVerificationId = id,
        codeAutoRetrievalTimeout: (id) => codeVerificationId = id,
      );

  Future<void> verifySmsCode(String code) async {
    if (codeVerificationId == null) {
      throw SocialAuthException(
          message: Strings.errorVerificationCodeIsInvalid);
    }
    await _signInWithCredentials(PhoneAuthProvider.credential(
      verificationId: codeVerificationId!,
      smsCode: code,
    ));
  }

  Stream<UserResponse> fetchUserStream(
    String userId,
  ) =>
      _firestore
          .doc('${FirebaseCollections.users}/$userId')
          .snapshots()
          .where((snap) => snap.data() != null)
          .map(
            (snap) => UserResponse.fromJson(snap.data(), id: snap.id),
          );

  Future<bool> isFirebaseUserExist(User user) => _firestore
      .collection(FirebaseCollections.users)
      .doc(user.uid)
      .get()
      .then((value) => value.exists);

  Future<void> deleteUser(String userId) =>
      _firestore.doc('${FirebaseCollections.users}/$userId').delete();
}
