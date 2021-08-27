import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/view/hub/hub_viewdata.dart';
import 'package:dairo/presentation/view/hub/widgets/appbar_hub.dart';
import 'package:dairo/presentation/view/users/users_viewdata.dart';
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

  void _onUserRetrieved(User? user) => viewData.user = user;

  void _onPublicationsRetrieved(List<Publication> publications) =>
      viewData.publications = publications;

  void _onHubRetrieved(Hub? hub) => viewData.hub = hub;

  void onCreatePublicationClicked() => _navigationService.navigateTo(
        Routes.newPublicationView,
        arguments: NewPublicationViewArguments(hubId: hubId),
      );

  void onMenuItemClicked(HubMenuItem? item) {}

  void onPublicationLikeClicked(String publicationId, bool isLiked) =>
      _publicationRepository.sendLike(
        publicationId: publicationId,
        isLiked: isLiked,
      );

  void onUsersLikedScreenClicked(String publicationId) async {
    List<String> userIds =
        await _publicationRepository.getUsersLiked(publicationId);
    return _navigationService.navigateTo(
      Routes.usersView,
      arguments: UsersViewArguments(
        userIds: userIds,
        type: UsersType.Likes,
      ),
    );
  }

  void onPublicationDetailsClicked(Publication publication) =>
      _navigationService.navigateTo(
        Routes.publicationView,
        arguments: PublicationViewArguments(
          publicationId: publication.id,
          userId: publication.userId,
        ),
      );

  void onFollowClicked() => viewData.hub!.isFollow
      ? _hubRepository.onUnfollow(viewData.hub!.id)
      : _hubRepository.onFollow(viewData.hub!.id);

  void onFollowersClicked() async {
    List<String> userIds = await _hubRepository.getHubFollowersIds(hubId);
    return _navigationService.navigateTo(
      Routes.usersView,
      arguments: UsersViewArguments(
        userIds: userIds,
        type: UsersType.Followers,
      ),
    );
  }

  bool isCurrentUser() => _userRepository.isCurrentUser(viewData.user!.id);
}
