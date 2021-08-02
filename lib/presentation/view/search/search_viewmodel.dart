import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/explore/explore_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseViewModel {
  TextEditingController searchTextController = new TextEditingController();
  List<dynamic> topSearchResults = [];
  List<User> profileSearchResults = [];
  List<Hub> hubSearchResults = [];
  final ExploreRepository _exploreRepository = locator<ExploreRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void onSearchSubmitted(String query) {
    Future.wait([
      _exploreRepository
          .searchProfiles(query)
          .then((result) => profileSearchResults = result),
      _exploreRepository
          .searchHubs(query)
          .then((result) => hubSearchResults = result)
    ]).then((_) {
      topSearchResults = List.from(profileSearchResults)
        ..addAll(hubSearchResults)
        ..shuffle();
      notifyListeners();
    });
  }

  void onProfileClicked(User user) {
    _navigationService.navigateTo(Routes.userProfileView,
        arguments: UserProfileViewArguments(userId: user.id));
  }

  void onHubSelected(Hub hub) async {
    _userRepository.getUser(hub.userId).first.then((user) {
      _navigationService.navigateTo(Routes.hubView,
          arguments: HubViewArguments(hub: hub, user: user!));
    });
  }
}
