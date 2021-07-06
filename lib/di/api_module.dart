import 'package:dairo/data/api/dairo_api.dart';
import 'package:dairo/data/api/interceptors/auth_interceptor.dart';
import 'package:dairo/data/api/interceptors/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @lazySingleton
  DairoApi get dairoApi {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LoggingInterceptor());
    return DairoApi(dio);
  }
}
