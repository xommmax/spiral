import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/repository/explore_remote_repository.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/explore/explore_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteRepository _remote = locator<ExploreRemoteRepository>();

  @override
  Future<List<User>> searchProfiles(String searchQuery) =>
      _remote.searchProfiles(searchQuery).then((responses) =>
          responses.map((response) => User.fromResponse(response)).toList());

  @override
  Future<List<Hub>> searchHubs(String searchQuery) =>
      _remote.searchHubs(searchQuery).then((responses) =>
          responses.map((response) => Hub.fromResponse(response)).toList());
}
