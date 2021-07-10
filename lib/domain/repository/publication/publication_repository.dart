import 'package:dairo/domain/model/publication/publication.dart';

abstract class PublicationRepository {
  Future<void> createPublication(Publication publication);

  Stream<List<Publication>> getUserPublicationsStream(String hubId);

  void refreshPublications(String hubId);
}
