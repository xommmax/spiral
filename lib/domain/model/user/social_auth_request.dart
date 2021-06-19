class SocialAuthRequest {
  final String? data;
  final SocialAuthType type;

  const SocialAuthRequest({
    this.data,
    required this.type,
  });
}

enum SocialAuthType {
  Phone,
  Google,
  Apple,
  Facebook,
}
