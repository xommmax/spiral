import 'package:dairo/app/locator.dart';
import 'package:dairo/data/db/entity/comment_item_data.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:injectable/injectable.dart';

import '../dairo_database.dart';

@lazySingleton
class PublicationLocalRepository {
  final DairoDatabase _database = locator<DairoDatabase>();

  Stream<List<PublicationItemData>> getPublications(String hubId) =>
      _database.publicationDao.getPublications(hubId);

  Stream<PublicationItemData?> getPublication(String publicationId) =>
      _database.publicationDao.getPublication(publicationId);

  Future<void> addPublication(PublicationItemData publication) =>
      _database.publicationDao.insertPublication(publication);

  Future<void> addPublications(List<PublicationItemData> publications) =>
      _database.publicationDao.insertPublications(publications);

  Future<void> updatePublication(PublicationItemData publication) =>
      _database.publicationDao.updatePublication(publication);

  Future<void> updatePublications(
          List<PublicationItemData> publications, String hubId) =>
      _database.publicationDao.updatePublications(publications, hubId);

  Future<void> addComment(CommentItemData comment) =>
      _database.commentDao.insertComment(comment);

  Stream<List<CommentItemData>> getComments(String publicationId) =>
      _database.commentDao.getComments(publicationId);

  Future<void> updateComments(
          List<CommentItemData> comments, String publicationId) =>
      _database.commentDao.updateComments(comments, publicationId);
}
