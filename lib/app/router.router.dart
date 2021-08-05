// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../domain/model/hub/hub.dart';
import '../domain/model/user/user.dart';
import '../presentation/view/auth/auth_view.dart';
import '../presentation/view/hub/hub_view.dart';
import '../presentation/view/main/main_view.dart';
import '../presentation/view/new_hub/new_hub_view.dart';
import '../presentation/view/new_publication/new_publication_view.dart';
import '../presentation/view/profile/current_user/current_user_profile_view.dart';
import '../presentation/view/profile/user/user_profile_view.dart';
import '../presentation/view/publication/users_liked/users_liked_view.dart';
import '../presentation/view/search/search_view.dart';

class Routes {
  static const String authView = '/auth-view';
  static const String mainView = '/';
  static const String newPublicationView = '/new-publication-view';
  static const String userProfileView = '/user-profile-view';
  static const String currentUserProfileView = '/current-user-profile-view';
  static const String newHubView = '/new-hub-view';
  static const String hubView = '/hub-view';
  static const String usersLikedView = '/users-liked-view';
  static const String searchView = '/search-view';
  static const all = <String>{
    authView,
    mainView,
    newPublicationView,
    userProfileView,
    currentUserProfileView,
    newHubView,
    hubView,
    usersLikedView,
    searchView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.newPublicationView, page: NewPublicationView),
    RouteDef(Routes.userProfileView, page: UserProfileView),
    RouteDef(Routes.currentUserProfileView, page: CurrentUserProfileView),
    RouteDef(Routes.newHubView, page: NewHubView),
    RouteDef(Routes.hubView, page: HubView),
    RouteDef(Routes.usersLikedView, page: UsersLikedView),
    RouteDef(Routes.searchView, page: SearchView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    AuthView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AuthView(),
        settings: data,
      );
    },
    MainView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainView(),
        settings: data,
      );
    },
    NewPublicationView: (data) {
      var args = data.getArgs<NewPublicationViewArguments>(
        orElse: () => NewPublicationViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewPublicationView(hubId: args.hubId),
        settings: data,
      );
    },
    UserProfileView: (data) {
      var args = data.getArgs<UserProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserProfileView(userId: args.userId),
        settings: data,
      );
    },
    CurrentUserProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CurrentUserProfileView(),
        settings: data,
      );
    },
    NewHubView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewHubView(),
        settings: data,
      );
    },
    HubView: (data) {
      var args = data.getArgs<HubViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HubView(
          hub: args.hub,
          user: args.user,
        ),
        settings: data,
      );
    },
    UsersLikedView: (data) {
      var args = data.getArgs<UsersLikedViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => UsersLikedView(userIds: args.userIds),
        settings: data,
      );
    },
    SearchView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// NewPublicationView arguments holder class
class NewPublicationViewArguments {
  final String? hubId;
  NewPublicationViewArguments({this.hubId});
}

/// UserProfileView arguments holder class
class UserProfileViewArguments {
  final String userId;
  UserProfileViewArguments({required this.userId});
}

/// HubView arguments holder class
class HubViewArguments {
  final Hub hub;
  final User user;
  HubViewArguments({required this.hub, required this.user});
}

/// UsersLikedView arguments holder class
class UsersLikedViewArguments {
  final List<String> userIds;
  UsersLikedViewArguments({required this.userIds});
}
