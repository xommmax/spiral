
class SocialAuthException implements Exception {
  final String message;

  SocialAuthException({
    required this.message,
  });
}