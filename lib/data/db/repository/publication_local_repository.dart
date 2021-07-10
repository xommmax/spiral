import 'package:dairo/app/locator.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:injectable/injectable.dart';

import '../dairo_database.dart';

@lazySingleton
class PublicationLocalRepository {
  final DairoDatabase _database = locator<DairoDatabase>();

  Future<void> addPublication(PublicationItemData publication) =>
      _database.publicationDao.insertPublication(publication);

  Future<void> addPublications(List<PublicationItemData> publications) =>
      _database.publicationDao.insertPublications(publications);

  Stream<List<PublicationItemData>> getUserPublicationsStream(String hubId) =>
      _database.publicationDao.getUserPublicationsStream(hubId);
}
