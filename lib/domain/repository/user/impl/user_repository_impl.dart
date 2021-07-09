import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/user_request.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/user_remote_repository.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/data/db/repository/user_local_repository.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteRepository _remote = locator<UserRemoteRepository>();
  final UserLocalRepository _local = locator<UserLocalRepository>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription? _streamSubscription;

  @override
  subscribeToFirebaseUserChanges() {
    _streamSubscription = FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null && !user.isAnonymous) {
        User domainUser = User(
          id: user.uid,
          displayName: user.displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          photoURL: user.photoURL,
        );
        print('Firebase User retrieved: ${domainUser.toString()}');
        updateUser(domainUser);
      }
    });
  }

  @override
  Future<void> tryToRegister(SocialAuthRequest request) =>
      _remote.tryToRegister(request);

  @override
  Future<User?> getUser({String? userId}) async {
    UserItemData? itemData = await _local.getUser(_checkUserId(userId));
    if (itemData == null) return null;
    return User.fromItemData(itemData);
  }

  @override
  Future<bool> isUserExist({String? userId}) async {
    if (_auth.currentUser == null) return false;
    return (await getUser(userId: _checkUserId(userId))) != null;
  }

  @override
  Stream<User?> getUserStream({String? userId}) =>
      _local.getUserStream(_checkUserId(userId)).map((itemData) {
        if (itemData == null) return null;
        return User.fromItemData(itemData);
      });

  @override
  Future<void> updateUser(User user) async {
    try {
      await _remote.updateUser(UserRequest.fromDomain(user));
      UserResponse? response = await _remote.fetchUser(user.id);
      if (response != null) {
        _local.updateUser(UserItemData.fromResponse(response));
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  @override
  Future<void> logoutUser() async {
    await _auth.signOut();
    _local.deleteUser();
  }

  @override
  void onVerificationCodeProvided(String code) =>
      _remote.onVerificationCodeProvided(code);

  @override
  dispose() {
    _streamSubscription?.cancel();
  }

  String _checkUserId(String? userId) => userId ?? _auth.currentUser!.uid;
}
