import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/home/home_viewdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends MultipleStreamViewModel {
  static const String CURRENT_USER_STREAM_KEY = 'CURRENT_USER_STREAM_KEY';
  static const String FEED_PUBLICATIONS_STREAM_KEY =
      'FEED_PUBLICATIONS_STREAM_KEY';
  static const String ONBOARDING_STREAM_KEY = 'ONBOARDING_STREAM_KEY';

  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();

  final HomeViewData viewData = HomeViewData();

  @override
  Map<String, StreamData> get streamsMap => _userRepository.isCurrentUserExist()
      ? {
          CURRENT_USER_STREAM_KEY: StreamData<User?>(
            _getCurrentUserStream(),
            onData: _onUserRetrieved,
          ),
          FEED_PUBLICATIONS_STREAM_KEY: StreamData<List<Publication?>>(
            _getFeedPublicationsStream(),
            onData: _onFeedPublicationsRetrieved,
          ),
        }
      : {
          ONBOARDING_STREAM_KEY: StreamData<SharedPreferences>(
              Stream.fromFuture(SharedPreferences.getInstance()),
              onData: _onOnboardingRetrieved)
        };

  Stream<User?> _getCurrentUserStream() => _userRepository.getCurrentUser();

  Stream<List<Publication?>> _getFeedPublicationsStream() =>
      _publicationRepository.getFeedPublications();

  Stream<List<User?>> _getUsersStream(List<String> userIds) =>
      _userRepository.getUsers(userIds);

  Stream<List<Hub?>> _getHubsStream(List<String> hubIds) =>
      _hubRepository.getHubsByIds(hubIds);

  void _onOnboardingRetrieved(SharedPreferences? sharedPreferences) {
    // if (sharedPreferences != null) {
    //   bool? isOnboardingCompleted = sharedPreferences
    //       .getBool(SharedPreferencesKeys.isOnboardingCompleted);
    //   if (isOnboardingCompleted != true) {
    //     _navigationService.clearStackAndShow(
    //       Routes.hubView,
    //       arguments: HubViewArguments(
    //           hubId: FirebaseDocuments.onboardingHub,
    //           userId: "onboardingUser",
    //           onboarding: true),
    //     );
    //   }
    // }
  }

  void _onUserRetrieved(User? user) => viewData.user = user;

  void _onFeedPublicationsRetrieved(List<Publication?> data) {
    viewData.publications = data;

    _getUsersStream(data.map((publication) => publication!.userId).toList())
        .listen((users) {
      for (User? user in users) {
        viewData.users[user!.id] = user;
      }
      notifyListeners();
    });

    _getHubsStream(data.map((publication) => publication!.hubId).toList())
        .listen((hubs) {
      for (Hub? hub in hubs) {
        viewData.hubs[hub!.id] = hub;
      }
      notifyListeners();
    });
  }

  void onAccountIconClicked() async {
    if (_userRepository.isCurrentUserExist()) {
      _navigationService.navigateTo(Routes.currentUserProfileView);
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result) {
          notifySourceChanged(clearOldData: true);
          initialise();
          _navigationService.navigateTo(Routes.currentUserProfileView);
        }
      });
    }
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
}
