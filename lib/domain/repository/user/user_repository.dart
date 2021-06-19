import 'package:dairo/domain/model/base/result.dart';
import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/model/user/user.dart';

abstract class UserRepository {
  subscribeToFirebaseUserChanges();

  Future<void> tryToRegister(SocialAuthRequest request);

  Future<Result<User?>> getUser();

  Stream<Result<User?>> getUserStream();

  void updateUser(User user);

  void onVerificationCodeProvided(String code);

  void deleteUser();

  dispose();
}
