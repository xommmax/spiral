import 'package:flutter_dotenv/flutter_dotenv.dart';

late $ENV ENV;

const _envFile = String.fromEnvironment("ENV", defaultValue: "dev");

/// type-safe, strongly typed wrapper around dotenv
class $ENV {
  final bool useFirebaseEmulator;
  final String firebaseBaseUrl;

  $ENV._({
    required this.useFirebaseEmulator,
    required this.firebaseBaseUrl,
  });

  @override
  String toString() => _envFile;

  static Future<void> load() async {
    await dotenv.load(fileName: ".$_envFile.env");
    final env = dotenv.env;
    ENV = $ENV._(
      useFirebaseEmulator: env["FIREBASE_EMULATOR"] == "true",
      firebaseBaseUrl: env["FIREBASE_BASE_URL"]!,
    );
  }
}
