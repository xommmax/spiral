class SocialAuthRequest {
  final SocialAuthType type;

  const SocialAuthRequest(this.type);
}

enum SocialAuthType {
  Google,
  Apple,
  Facebook,
}
