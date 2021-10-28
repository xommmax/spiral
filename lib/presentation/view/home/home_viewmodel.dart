import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/view/home/home_viewdata.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends MultipleStreamViewModel {
  static const String CURRENT_USER_STREAM_KEY = 'CURRENT_USER_STREAM_KEY';
  static const String FEED_PUBLICATIONS_STREAM_KEY =
      'FEED_PUBLICATIONS_STREAM_KEY';

  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();

  final HomeViewData viewData = HomeViewData();

  @override
  Map<String, StreamData> get streamsMap => {
        CURRENT_USER_STREAM_KEY: StreamData<User?>(
          _getCurrentUserStream(),
          onData: _onUserRetrieved,
        ),
        FEED_PUBLICATIONS_STREAM_KEY: StreamData<List<String>>(
          _getFeedPublicationsStream(),
          onData: _onFeedPublicationsRetrieved,
        ),
      };

  Stream<User?> _getCurrentUserStream() => _userRepository.getCurrentUser();

  Stream<List<String>> _getFeedPublicationsStream() =>
      _publicationRepository.getFeedPublicationIds();

  void _onUserRetrieved(User? user) => viewData.currentUser = user;

  void _onFeedPublicationsRetrieved(List<String> data) {
    viewData.publicationIds = data;
  }

  void onAccountIconClicked() =>
      _navigationService.navigateTo(Routes.currentUserProfileView);

  void onMessageIconClicked() =>
      _navigationService.navigateTo(Routes.messagingView);
}
