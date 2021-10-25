import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/hub/hub_viewdata.dart';
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HubViewModel extends MultipleStreamViewModel {
  static const PUBLICATIONS_STREAM_KEY = 'PUBLICATIONS_STREAM_KEY';
  static const USER_STREAM_KEY = 'USER_STREAM_KEY';
  static const HUB_STREAM_KEY = 'HUB_STREAM_KEY';

  final String hubId;
  final String userId;

  HubViewModel({
    required this.hubId,
    required this.userId,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();
  final SupportRepository _supportRepository = locator<SupportRepository>();

  final HubViewData viewData = HubViewData();

  @override
  Map<String, StreamData> get streamsMap => {
        USER_STREAM_KEY: StreamData<User?>(
          userStream(),
          onData: _onUserRetrieved,
        ),
        PUBLICATIONS_STREAM_KEY: StreamData<List<Publication>?>(
          publicationsStream(),
          onData: _onPublicationsRetrieved,
        ),
        HUB_STREAM_KEY: StreamData<Hub?>(
          hubStream(),
          onData: _onHubRetrieved,
        ),
      };

  Stream<User?> userStream() => _userRepository.getUser(userId);

  Stream<List<Publication>?> publicationsStream() =>
      _publicationRepository.getPublications(hubId);

  Stream<Hub?> hubStream() => _hubRepository.getHub(hubId);

  Stream<User?> getUser(String userId) => _userRepository.getUser(userId);

  void _onUserRetrieved(User? user) => viewData.user = user;

  void _onPublicationsRetrieved(List<Publication> publications) {
    viewData.textControllers.forEach((controller) => controller.dispose());
    viewData.textControllers = [];
    publications.forEach((publication) =>
        viewData.textControllers.add(initTextController(publication)));
    viewData.publications = publications;
  }

  void _onHubRetrieved(Hub? hub) => viewData.hub = hub;

  void onSettingsClicked() {
    _navigationService.navigateTo(
      Routes.hubSettingsView,
    );
  }

  void onFabPressed() {
    openDiscussion();
  }

  void onCreatePublicationClicked() {
    if (viewData.hub != null)
      _navigationService.navigateTo(
        Routes.newPublicationView,
        arguments: NewPublicationViewArguments(hub: viewData.hub!),
      );
  }

  void onPublicationLikeClicked(String publicationId, bool isLiked) =>
      _publicationRepository.sendLike(
        publicationId: publicationId,
        isLiked: isLiked,
      );

  void onUsersLikedScreenClicked(String publicationId) async {
    List<String> userIds =
        await _publicationRepository.getUsersLiked(publicationId);
    return _navigationService.navigateTo(
      Routes.followersView,
      arguments: FollowersViewArguments(
        userIds: userIds,
        type: FollowersType.Likes,
      ),
    );
  }

  void onPublicationDetailsClicked(Publication publication) =>
      _navigationService.navigateTo(
        Routes.publicationView,
        arguments: PublicationViewArguments(
          publicationId: publication.id,
          userId: publication.userId,
          hubId: publication.hubId,
        ),
      );

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

  bool isCurrentUser() {
    var user = viewData.user;
    if (user == null) return false;
    return _userRepository.isCurrentUser(user.id);
  }

  void onBackPressed() => _navigationService.back();

  void onSettingsPressed() {
    final hub = viewData.hub;
    if (hub != null)
      _navigationService.navigateTo(Routes.hubSettingsView,
          arguments: HubSettingsViewArguments(hub: hub));
  }

  onUserClicked(User? user) {
    if (user == null) return;
    _navigationService.navigateTo(Routes.userProfileView,
        arguments: UserProfileViewArguments(userId: user.id));
  }

  onHubClicked(Hub? hub) {
    if (hub == null) return;
    _navigationService.navigateTo(Routes.hubView,
        arguments: HubViewArguments(hubId: hub.id, userId: hub.userId));
  }

  void onReport(Publication publication) {
    _supportRepository.reportPublication(
        publicationId: publication.id, reason: "TODO");
    AppDialog.showInformDialog(
        title: Strings.reported, description: Strings.reportedPublicationDesc);
  }

  void onDelete(Publication publication) {
    _publicationRepository.deletePublication(publicationId: publication.id);
  }

  void openDiscussion() {
    _navigationService.navigateTo(Routes.hubDiscussionView,
        arguments: HubDiscussionViewArguments(hub: viewData.hub!));
  }

  @override
  void dispose() {
    viewData.textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
