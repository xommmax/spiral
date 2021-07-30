import 'package:dairo/app/env.dart';
import 'package:dairo/data/api/dairo_api.dart';
import 'package:dairo/data/api/interceptor/auth_interceptor.dart';
import 'package:dairo/data/api/interceptor/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @lazySingleton
  DairoApi get dairoApi => DairoApi(
        _getDio(),
        baseUrl: _getBaseUrl(),
      );

  Dio _getDio() => Dio()
    ..interceptors.add(AuthInterceptor())
    ..interceptors.add(LoggingInterceptor());

  String _getBaseUrl() {
    final url = ENV.firebaseBaseUrl;
    if (ENV.useFirebaseEmulator &&
        defaultTargetPlatform == TargetPlatform.android) {
      return url.replaceAll("localhost", "10.0.2.2");
    } else {
      return url;
    }
  }
}
