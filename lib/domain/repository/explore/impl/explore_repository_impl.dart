import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/explore_remote_repository.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/data/db/repository/hub_local_repository.dart';
import 'package:dairo/data/db/repository/publication_local_repository.dart';
import 'package:dairo/data/db/repository/user_local_repository.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/explore/explore_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteRepository _exploreRemote =
      locator<ExploreRemoteRepository>();
  final UserLocalRepository _userLocal = locator<UserLocalRepository>();
  final HubLocalRepository _hubLocal = locator<HubLocalRepository>();
  final PublicationLocalRepository _publicationLocal =
      locator<PublicationLocalRepository>();

  @override
  Future<List<User>> searchProfiles(String searchQuery) async {
    List<UserResponse> responses =
        await _exploreRemote.searchProfiles(searchQuery);
    List<UserItemData> itemData = responses
        .map((response) => UserItemData.fromResponse(response))
        .toList();
    _userLocal.addUsers(itemData);
    return itemData.map((itemData) => User.fromItemData(itemData)).toList();
  }

  @override
  Future<List<Hub>> searchHubs(String searchQuery) async {
    List<HubResponse> responses = await _exploreRemote.searchHubs(searchQuery);
    List<HubItemData> itemData = responses
        .map((response) => HubItemData.fromResponse(response))
        .toList();
    _hubLocal.addHubs(itemData);
    return itemData.map((itemData) => Hub.fromItemData(itemData)).toList();
  }

  @override
  Future<List<Publication>> getExplorePublications() async {
    List<PublicationResponse> responses =
        await _exploreRemote.fetchExplorePublications();
    List<PublicationItemData> itemData = responses
        .map((response) => PublicationItemData.fromResponse(response))
        .toList();
    _publicationLocal.addPublications(itemData);
    return itemData
        .map((itemData) => Publication.fromItemData(itemData))
        .toList();
  }

  @override
  Future<List<Publication>> getRecentPublications() async {
    List<PublicationResponse> responses =
        await _exploreRemote.fetchRecentPublications();
    List<PublicationItemData> itemData = responses
        .map((response) => PublicationItemData.fromResponse(response))
        .toList();
    _publicationLocal.addPublications(itemData);
    return itemData
        .map((itemData) => Publication.fromItemData(itemData))
        .toList();
  }

  @override
  Future<List<Hub>> getExploreHubs() async {
    List<HubResponse> responses = await _exploreRemote.fetchExploreHubs();
    List<HubItemData> itemData = responses
        .map((response) => HubItemData.fromResponse(response))
        .toList();
    _hubLocal.addHubs(itemData);
    return itemData.map((itemData) => Hub.fromItemData(itemData)).toList();
  }

  @override
  Future<List<String>> getExploreHubMediaPreviews(String hubId) =>
      _exploreRemote.getExploreHubMediaPreviews(hubId);
}
