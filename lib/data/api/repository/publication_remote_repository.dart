import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/dairo_api.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PublicationRemoteRepository {
  final DairoApi _remote = locator<DairoApi>();

  Future<void> sendPublication(PublicationRequest request) =>
      _remote.sendPublication(
        inputText: request.text,
        files: request.mediaFiles,
      );
}
