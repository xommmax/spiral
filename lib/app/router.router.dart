// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../presentation/view/auth/auth_view.dart';
import '../presentation/view/new_publication/new_publication_view.dart';
import '../presentation/view/splash/splash_view.dart';

class Routes {
  static const String splashView = '/splash-view';
  static const String authView = '/auth-view';
  static const String newPublicationView = '/';
  static const all = <String>{
    splashView,
    authView,
    newPublicationView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.newPublicationView, page: NewPublicationView),
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
    NewPublicationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewPublicationView(),
        settings: data,
      );
    },
  };
}
