import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/report_request.dart';
import 'package:dairo/data/api/model/request/support_request.dart';
import 'package:dairo/data/api/repository/support_remote_repository.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SupportRepository)
class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteRepository _remote = locator<SupportRemoteRepository>();
  final UserRepository userRepository = locator<UserRepository>();

  @override
  Future<void> sendSupportRequest({
    required String subject,
    required String description,
  }) {
    final currentUserId = userRepository.getCurrentUserId();
    return _remote.sendSupportRequest(
      SupportRequest(
        subject: subject,
        description: description,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        userId: currentUserId,
      ),
    );
  }

  @override
  Future<void> reportPublication({
    required String publicationId,
    required String reason,
  }) {
    final currentUserId = userRepository.getCurrentUserId();
    return _remote.sendReport(ReportRequest(
      subjectId: publicationId,
      subjectType: "publication",
      reporterId: currentUserId,
      reason: reason,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ));
  }

  @override
  Future<void> reportUser({
    required String userId,
    required String reason,
  }) {
    final currentUserId = userRepository.getCurrentUserId();
    return _remote.sendReport(ReportRequest(
      subjectId: userId,
      subjectType: "user",
      reporterId: currentUserId,
      reason: reason,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ));
  }
}
