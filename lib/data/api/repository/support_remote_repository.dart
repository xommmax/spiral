import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/firestore_keys.dart';
import 'package:dairo/data/api/model/request/report_request.dart';
import 'package:dairo/data/api/model/request/support_request.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SupportRemoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendSupportRequest(SupportRequest request) => _firestore
      .collection(FirebaseCollections.usersSupportRequests)
      .add(request.toJson());

  Future<void> sendReport(ReportRequest request) => _firestore
      .collection(FirebaseCollections.reportRequests)
      .add(request.toJson());

  Future<void> blockUser(String reporterId, String blockedUserId) => _firestore
      .collection(
          '${FirebaseCollections.blockedUsers}/$reporterId/${FirestoreKeys.blockedUsers}')
      .doc(blockedUserId)
      .set({});

  Future<bool> isUserBlockedByCurrentUser(
      String currentUserId, String userId) async {
    return _firestore
        .doc(
            '${FirebaseCollections.blockedUsers}/$currentUserId/${FirestoreKeys.blockedUsers}/$userId')
        .get()
        .then((snapshot) => snapshot.exists);
  }
}
