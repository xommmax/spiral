import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/view/home/home_viewdata.dart';
import 'package:dairo/presentation/view/main/main_nav_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@LazySingleton()
class HomeViewModel extends MultipleStreamViewModel {
  static const String CURRENT_USER_STREAM_KEY = 'CURRENT_USER_STREAM_KEY';
  static const String FEED_PUBLICATIONS_STREAM_KEY =
      'FEED_PUBLICATIONS_STREAM_KEY';

  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final MainNavService mainNavService = locator<MainNavService>();
  final HomeViewData viewData = HomeViewData();
  final ScrollController scrollController = ScrollController();

  HomeViewModel() {
    mainNavService.homeDoubleClickCallback = _scrollToTheTop;
  }

  void _scrollToTheTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

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

  void _onUserRetrieved(User? user) {
    viewData.currentUser = user;
  }

  void _onFeedPublicationsRetrieved(List<String> data) {
    viewData.publicationIds = data;
  }

  void onAccountIconClicked() =>
      _navigationService.navigateTo(Routes.currentUserProfileView);

  void onMessageIconClicked() =>
      _navigationService.navigateTo(Routes.messagingView);

  void goToExplore() {
    mainNavService.goToExplore();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
