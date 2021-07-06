// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dairo_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DairoApi implements DairoApi {
  _DairoApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<void> sendPublication({inputText, required files}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (inputText != null) {
      _data.fields.add(MapEntry('inputText', inputText));
    }
    _data.files.addAll(files.map((i) => MapEntry(
        'files',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'sendPublication',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
