import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/data/api/model/request/report_request.dart';
import 'package:dairo/data/api/model/request/support_request.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SupportRemoteRepository {
  Future<void> sendSupportRequest(SupportRequest request) =>
      FirebaseFirestore.instance
          .collection(FirebaseCollections.usersSupportRequests)
          .add(request.toJson());

  Future<void> sendReport(ReportRequest request) => FirebaseFirestore.instance
      .collection(FirebaseCollections.reportRequests)
      .add(request.toJson());
}
