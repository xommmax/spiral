abstract class SupportRepository {
  Future<void> sendSupportRequest({
    required String subject,
    required String description,
  });

  Future<void> reportPublication({
    required String publicationId,
    required String reason,
  });

  Future<void> reportUser({
    required String userId,
    required String reason,
  });

  Future<void> blockUser({
    required String userId,
  });

  Future<bool> isUserBlockedByCurrentUser({
    required String userId,
  });
}
