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

  @override
  Future<void> blockUser({required String userId}) {
    final currentUserId = userRepository.getCurrentUserId();
    return _remote.blockUser(currentUserId, userId);
  }

  @override
  Future<bool> isUserBlockedByCurrentUser({required String userId}) async {
    if (!userRepository.isCurrentUserExist()) return false;
    final currentUserId = userRepository.getCurrentUserId();
    return _remote.isUserBlockedByCurrentUser(currentUserId, userId);
  }

  @override
  Future<void> sendContactRequest({
    required String type,
    String? subject,
    String? description,
    String? email,
  }) {
    final currentUserId = userRepository.getCurrentUserId();
    return _remote.sendContactRequest(
      SupportRequest(
        type: type,
        subject: subject,
        description: description,
        email: email,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        userId: currentUserId,
      ),
    );
  }
}
