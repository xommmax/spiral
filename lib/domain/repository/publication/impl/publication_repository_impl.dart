import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/repository/publication_remote_repository.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PublicationRepository)
class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationRemoteRepository _remote =
      locator<PublicationRemoteRepository>();

  @override
  Future<void> sendPublication(Publication publication) =>
      _remote.sendPublication(PublicationRequest.fromDomain(publication));
}
