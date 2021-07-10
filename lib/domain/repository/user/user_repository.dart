import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/model/user/user.dart';

abstract class UserRepository {
  Future<dynamic> register(SocialAuthRequest request);

  Future<User?> getUser(String userId);

  Future<User?> getCurrentUser();

  Stream<User?> getCurrentUserStream();

  Future<bool> isUserExist(String userId);

  Future<bool> isCurrentUserExist();

  void updateUser(User user);

  Future<dynamic> onVerificationCodeProvided(String code);

  Future<void> logoutUser();

  String? getCurrentUserPhotoUrl();
}
