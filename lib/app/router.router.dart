// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../presentation/view/auth/auth_view.dart';
import '../presentation/view/hub/hub_view.dart';
import '../presentation/view/hubs/hubs_view.dart';
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
import '../presentation/view/users/users_view.dart';
import '../presentation/view/users/users_viewdata.dart';

class Routes {
  static const String authView = '/auth-view';
  static const String mainView = '/';
  static const String newPublicationView = '/new-publication-view';
  static const String userProfileView = '/user-profile-view';
  static const String currentUserProfileView = '/current-user-profile-view';
  static const String newHubView = '/new-hub-view';
  static const String hubView = '/hub-view';
  static const String usersView = '/users-view';
  static const String publicationView = '/publication-view';
  static const String searchView = '/search-view';
  static const String settingsView = '/settings-view';
  static const String accountDetailsView = '/account-details-view';
  static const String supportView = '/support-view';
  static const String hubsView = '/hubs-view';
  static const all = <String>{
    authView,
    mainView,
    newPublicationView,
    userProfileView,
    currentUserProfileView,
    newHubView,
    hubView,
    usersView,
    publicationView,
    searchView,
    settingsView,
    accountDetailsView,
    supportView,
    hubsView,
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
    RouteDef(Routes.usersView, page: UsersView),
    RouteDef(Routes.publicationView, page: PublicationView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.accountDetailsView, page: AccountDetailsView),
    RouteDef(Routes.supportView, page: SupportView),
    RouteDef(Routes.hubsView, page: HubsView),
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
        ),
        settings: data,
      );
    },
    UsersView: (data) {
      var args = data.getArgs<UsersViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => UsersView(
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
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsView(),
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
    HubsView: (data) {
      var args = data.getArgs<HubsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HubsView(userIds: args.userIds),
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
  final String? userId;
  HubViewArguments({required this.hubId, this.userId});
}

/// UsersView arguments holder class
class UsersViewArguments {
  final List<String> userIds;
  final UsersType type;
  UsersViewArguments({required this.userIds, required this.type});
}

/// PublicationView arguments holder class
class PublicationViewArguments {
  final String publicationId;
  final String userId;
  PublicationViewArguments({required this.publicationId, required this.userId});
}

/// HubsView arguments holder class
class HubsViewArguments {
  final List<String> userIds;
  HubsViewArguments({required this.userIds});
}
