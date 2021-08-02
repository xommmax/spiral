import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logPrint('==> ${options.method} ${options.uri}');
    logPrint('HEADERS:');
    options.headers.forEach((key, v) => printKV(' - $key', v));
    logPrint('REQUEST:');
    if (options.data is FormData) {
      FormData formData = options.data as FormData;
      printAll(formData.fields.join('\n'));
      printAll(formData.files.join('\n'));
    } else {
      printAll(options.data ?? "");
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logPrint('$err');
    if (err.response != null) {
      logPrint('BODY: ${err.response?.toString()}');
    }
    logPrint(
        '<== ${err.response?.statusCode?.toString()} ${err.response?.requestOptions.uri.toString()}');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printAll('RESPONSE:\n${response.data ?? ""}');

    logPrint(
        '<== ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri.toString()}');
    super.onResponse(response, handler);
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void logPrint(String s) {
    debugPrint(s);
  }
}
