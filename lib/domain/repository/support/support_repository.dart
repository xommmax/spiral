abstract class SupportRepository {
  Future<void> sendContactRequest({
    required String type,
    String? subject,
    String? description,
    String? email,
  });

  Future<void> reportMessage({
    required String messageId,
    required String reason,
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
