import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'network_constants.dart';

part 'dairo_api.g.dart';

@RestApi(baseUrl: NetworkConstants.DOMEN)
abstract class DairoApi {
  factory DairoApi(Dio dio) = _DairoApi;

  @POST('sendPublication')
  @MultiPart()
  Future<void> sendPublication({
    @Part(name: 'inputText') String? inputText,
    @Part(name: 'files') required List<File> files,
  });
}
