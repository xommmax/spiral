// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../presentation/view/auth/auth_view.dart';
import '../presentation/view/hub/creation/hub_creation_view.dart';
import '../presentation/view/main/main_view.dart';
import '../presentation/view/new_publication/new_publication_view.dart';
import '../presentation/view/profile/base/profile_view.dart';
import '../presentation/view/splash/splash_view.dart';

class Routes {
  static const String splashView = '/splash-view';
  static const String authView = '/auth-view';
  static const String mainView = '/';
  static const String newPublicationView = '/new-publication-view';
  static const String profileView = '/profile-view';
  static const String hubCreationView = '/hub-creation-view';
  static const all = <String>{
    splashView,
    authView,
    mainView,
    newPublicationView,
    profileView,
    hubCreationView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.newPublicationView, page: NewPublicationView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.hubCreationView, page: HubCreationView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
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
      var args = data.getArgs<NewPublicationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewPublicationView(args.hubId),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(),
        settings: data,
      );
    },
    HubCreationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HubCreationView(),
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
  final String hubId;
  NewPublicationViewArguments({required this.hubId});
}
