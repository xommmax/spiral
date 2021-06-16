import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/user_request.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRemoteRepository {
  final FirebaseFirestore _remote = locator<FirebaseFirestore>();

  Future<UserResponse?> fetchUser(String userUid) => _remote
      .doc('/users/$userUid')
      .get()
      .catchError((error) =>
          throw Exception('Error while getting user from Firestore: $error'))
      .then(
        (snapshot) => snapshot.exists && snapshot.data() != null
            ? UserResponse.fromJson(snapshot.data()!)
            : null,
      );

  Future<void> updateUser(UserRequest request) => _remote
          .collection('/users')
          .doc('${request.uid}')
          .set(
            request.toJson(),
          )
          .catchError((error) {
        throw Exception('Error while updating user from Firestore: $error');
      });
}
