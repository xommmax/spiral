enum AuthMethod { Phone, Apple, Google }

extension AuthMethodToString on AuthMethod {
  String toShortString() => this.toString().split('.').last;
}