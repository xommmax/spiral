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

  UserRepositoryImpl() {
    _auth.userChanges().listen((firebaseUser) {
      if (firebaseUser != null && !firebaseUser.isAnonymous) {
        updateUser(User.fromFirebase(firebaseUser));

      }
    });
  }

  @override
  Future<dynamic> register(SocialAuthRequest request) =>
      _remote.register(request);

  @override
  Future<User?> getUser(String userId) async {
    UserItemData? itemData = await _local.getUser(userId);
    if (itemData == null) return null;
    return User.fromItemData(itemData);
  }

  @override
  Future<User?> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return null;
    return getUser(currentUser.uid);
  }

  @override
  Future<bool> isUserExist(String userId) async {
    final localUser = await getUser(userId);
    return localUser != null;
  }

  @override
  Future<bool> isCurrentUserExist() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return false;
    return isUserExist(currentUser.uid);
  }

  @override
  Stream<User?> getCurrentUserStream() {
    final currentUser = _auth.currentUser;
    if (currentUser == null)
      // TODO: wait for user auth instead of error throw
      throw UnauthorizedException();
    return _local.getUserStream(currentUser.uid).map((itemData) {
      if (itemData == null) return null;
      return User.fromItemData(itemData);
    });
  }

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
  Future<dynamic> onVerificationCodeProvided(String code) =>
      _remote.onVerificationCodeProvided(code);

  @override
  String? getCurrentUserPhotoUrl() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return null;
    return currentUser.photoURL;
  }
}
