import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';

abstract class ExploreRepository {
  Future<List<User>> searchProfiles(String searchQuery);

  Future<List<Hub>> searchHubs(String searchQuery);

  Future<List<Publication>> getExplorePublications();

  Future<List<Hub>> getExploreHubs();

  Future<List<String>> getExploreHubMediaPreviews(String hubId);
}
