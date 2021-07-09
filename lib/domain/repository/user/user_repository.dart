import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/model/user/user.dart';

abstract class UserRepository {
  subscribeToFirebaseUserChanges();

  Future<void> tryToRegister(SocialAuthRequest request);

  Future<User?> getUser({String? userId});

  Future<bool> isUserExist({String? userId});

  Stream<User?> getUserStream({String? userId});

  void updateUser(User user);

  void onVerificationCodeProvided(String code);

  Future<void> logoutUser();

  dispose();
}
