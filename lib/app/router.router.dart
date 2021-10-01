// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../domain/model/hub/hub.dart';
import '../presentation/view/auth/auth_view.dart';
import '../presentation/view/followers/followers_view.dart';
import '../presentation/view/followers/followers_viewdata.dart';
import '../presentation/view/followings/followings_view.dart';
import '../presentation/view/hub/hub_view.dart';
import '../presentation/view/hub/settings/hub_settings_view.dart';
import '../presentation/view/main/main_view.dart';
import '../presentation/view/new_hub/new_hub_view.dart';
import '../presentation/view/new_publication/new_publication_view.dart';
import '../presentation/view/profile/current_user/current_user_profile_view.dart';
import '../presentation/view/profile/user/user_profile_view.dart';
import '../presentation/view/publication/publication_view.dart';
import '../presentation/view/search/search_view.dart';
import '../presentation/view/settings/account/account_details_view.dart';
import '../presentation/view/settings/settings_view.dart';
import '../presentation/view/settings/support/support_view.dart';

class Routes {
  static const String authView = '/auth-view';
  static const String mainView = '/';
  static const String newPublicationView = '/new-publication-view';
  static const String userProfileView = '/user-profile-view';
  static const String currentUserProfileView = '/current-user-profile-view';
  static const String newHubView = '/new-hub-view';
  static const String hubView = '/hub-view';
  static const String followersView = '/followers-view';
  static const String publicationView = '/publication-view';
  static const String searchView = '/search-view';
  static const String profileSettingsView = '/profile-settings-view';
  static const String accountDetailsView = '/account-details-view';
  static const String supportView = '/support-view';
  static const String followingsView = '/followings-view';
  static const String hubSettingsView = '/hub-settings-view';
  static const all = <String>{
    authView,
    mainView,
    newPublicationView,
    userProfileView,
    currentUserProfileView,
    newHubView,
    hubView,
    followersView,
    publicationView,
    searchView,
    profileSettingsView,
    accountDetailsView,
    supportView,
    followingsView,
    hubSettingsView,
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
    RouteDef(Routes.followersView, page: FollowersView),
    RouteDef(Routes.publicationView, page: PublicationView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.profileSettingsView, page: ProfileSettingsView),
    RouteDef(Routes.accountDetailsView, page: AccountDetailsView),
    RouteDef(Routes.supportView, page: SupportView),
    RouteDef(Routes.followingsView, page: FollowingsView),
    RouteDef(Routes.hubSettingsView, page: HubSettingsView),
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
          hubId: args.hubId,
          userId: args.userId,
          onboarding: args.onboarding,
        ),
        settings: data,
      );
    },
    FollowersView: (data) {
      var args = data.getArgs<FollowersViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => FollowersView(
          userIds: args.userIds,
          type: args.type,
        ),
        settings: data,
      );
    },
    PublicationView: (data) {
      var args = data.getArgs<PublicationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PublicationView(
          args.publicationId,
          args.userId,
          args.hubId,
        ),
        settings: data,
      );
    },
    SearchView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchView(),
        settings: data,
      );
    },
    ProfileSettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileSettingsView(),
        settings: data,
      );
    },
    AccountDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccountDetailsView(),
        settings: data,
      );
    },
    SupportView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SupportView(),
        settings: data,
      );
    },
    FollowingsView: (data) {
      var args = data.getArgs<FollowingsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => FollowingsView(userIds: args.userIds),
        settings: data,
      );
    },
    HubSettingsView: (data) {
      var args = data.getArgs<HubSettingsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HubSettingsView(args.hub),
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
  final String hubId;
  final String userId;
  final bool onboarding;
  HubViewArguments(
      {required this.hubId, required this.userId, this.onboarding = false});
}

/// FollowersView arguments holder class
class FollowersViewArguments {
  final List<String> userIds;
  final FollowersType type;
  FollowersViewArguments({required this.userIds, required this.type});
}

/// PublicationView arguments holder class
class PublicationViewArguments {
  final String publicationId;
  final String userId;
  final String hubId;
  PublicationViewArguments(
      {required this.publicationId, required this.userId, required this.hubId});
}

/// FollowingsView arguments holder class
class FollowingsViewArguments {
  final List<String> userIds;
  FollowingsViewArguments({required this.userIds});
}

/// HubSettingsView arguments holder class
class HubSettingsViewArguments {
  final Hub hub;
  HubSettingsViewArguments({required this.hub});
}
