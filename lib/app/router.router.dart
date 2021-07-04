// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../presentation/view/account/account_view.dart';
import '../presentation/view/auth/auth_view.dart';
import '../presentation/view/main/main_view.dart';
import '../presentation/view/new_publication/new_publication_view.dart';
import '../presentation/view/splash/splash_view.dart';

class Routes {
  static const String splashView = '/splash-view';
  static const String authView = '/auth-view';
  static const String mainView = '/';
  static const String newPublicationView = '/new-publication-view';
  static const String accountView = '/account-view';
  static const all = <String>{
    splashView,
    authView,
    mainView,
    newPublicationView,
    accountView,
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
    RouteDef(Routes.accountView, page: AccountView),
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewPublicationView(),
        settings: data,
      );
    },
    AccountView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccountView(),
        settings: data,
      );
    },
  };
}
