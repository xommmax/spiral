import 'package:dairo/domain/model/user/social_auth_request.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

abstract class UserRepository {
  Future<void> loginWithSocial(SocialAuthRequest request);

  Future<void> registerWithPhone(String phoneNumber);

  Future<void> verifySmsCode(String code);

  Stream<User?> getCurrentUser();

  Stream<User?> getUser(String userId);

  Stream<List<User>> getUsers(List<String> userIds);

  bool isCurrentUserExist();

  Future<void> logoutUser();

  String getCurrentUserId();

  Future<void> saveUser({
    required String id,
    required String name,
    required String username,
    required int age,
    String? photoURL,
    String? defaultPhotoUrl,
    String? phoneNumber,
    String? email,
    String? description,
  });

  Future<void> updateUser({
    String? name,
    String? username,
    String? description,
    String? photoURL,
  });

  bool isCurrentUser(String userId);

  Future<bool> isFirebaseUserExist(firebase.User user);
}
