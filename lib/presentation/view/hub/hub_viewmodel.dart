import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/hub/hub_viewdata.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HubViewModel extends MultipleStreamViewModel {
  static const PUBLICATIONS_STREAM_KEY = 'PUBLICATIONS_STREAM_KEY';
  static const HUB_STREAM_KEY = 'HUB_STREAM_KEY';

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();
  final HubViewData viewData = HubViewData();

  final String hubId;
  final String userId;

  HubViewModel({
    required this.hubId,
    required this.userId,
  });

  @override
  Map<String, StreamData> get streamsMap => {
        PUBLICATIONS_STREAM_KEY: StreamData<List<String>>(
          publicationsStream(),
          onData: _onPublicationsRetrieved,
        ),
        HUB_STREAM_KEY: StreamData<Hub?>(
          hubStream(),
          onData: _onHubRetrieved,
        ),
      };

  Stream<List<String>> publicationsStream() =>
      _publicationRepository.getPublications(hubId);

  Stream<Hub?> hubStream() => _hubRepository.getHub(hubId);

  void _onPublicationsRetrieved(List<String> publicationIds) {
    viewData.publicationIds = publicationIds;
  }

  void _onHubRetrieved(Hub? hub) => viewData.hub = hub;

  void onFabPressed() {
    openDiscussion();
  }

  void openDiscussion() {
    _navigationService.navigateTo(Routes.hubDiscussionView,
        arguments: HubDiscussionViewArguments(hub: viewData.hub!));
  }

  void onFollowClicked() {
    final hub = viewData.hub;
    if (hub == null) return;
    hub.isFollow
        ? _hubRepository.onUnfollow(hub.id)
        : _hubRepository.onFollow(hub.id);
  }

  void onFollowersClicked() async {
    List<String> userIds = await _hubRepository.getHubFollowersIds(hubId);
    return _navigationService.navigateTo(
      Routes.followersView,
      arguments: FollowersViewArguments(
        userIds: userIds,
        type: FollowersType.Followers,
      ),
    );
  }

  void onBackPressed() => _navigationService.back();

  void onSettingsPressed() {
    final hub = viewData.hub;
    if (hub == null) return;
    _navigationService.navigateTo(Routes.hubSettingsView,
        arguments: HubSettingsViewArguments(hub: hub));
  }

  void onEditHubClicked() {
    if (viewData.hub == null) return;
    _navigationService.navigateTo(Routes.editHubView,
        arguments: EditHubViewArguments(hub: viewData.hub!));
  }

  bool isDataReady() => viewData.hub != null;

  bool isCurrentUser() => _userRepository.isCurrentUser(userId);
}
