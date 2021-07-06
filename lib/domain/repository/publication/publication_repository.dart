import 'package:dairo/domain/model/publication/publication.dart';

abstract class PublicationRepository {
  Future<void> sendPublication(Publication publication);
}
