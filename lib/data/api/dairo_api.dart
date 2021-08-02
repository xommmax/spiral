import 'package:dairo/data/api/model/request/like_publication_request.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'dairo_api.g.dart';

@RestApi()
abstract class DairoApi {
  factory DairoApi(Dio dio, {String baseUrl}) = _DairoApi;

  @POST('/sendLike')
  Future<PublicationResponse> sendLike(@Body() LikePublicationRequest request);

  @GET('/fetchPublications/{hubId}')
  Future<List<PublicationResponse>> fetchPublications(
    @Path('hubId') String hubId,
  );
}
