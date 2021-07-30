import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:country_codes/country_codes.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/env.dart';
import 'app/locator.dart';
import 'app/router.router.dart';

void main() async {
  await $ENV.load();
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await CountryCodes.init();
  FlutterError.onError = (details) {
    print(details.exceptionAsString());
    print(details.stack.toString());
  };
  runZonedGuarded(
      () => runApp(
            DairoApp(),
          ), (error, stacktrace) {
    print(error.toString());
    print(stacktrace.toString());
  });
}

class DairoApp extends StatefulWidget {
  @override
  _DairoAppState createState() => _DairoAppState();
}

class _DairoAppState extends State<DairoApp> {
  bool _initialized = false;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return SizedBox.shrink();
    }
    return MaterialApp(
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: _getAppTheme(),
      navigatorKey: StackedService.navigatorKey,
    );
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      _setupLocalFirebaseEnvironment();
      setState(() => _initialized = true);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  void _setupLocalFirebaseEnvironment() {
    if (ENV.useFirebaseEmulator) {
      FirebaseAuth.instance.useEmulator("http://localhost:9099");
      FirebaseFunctions.instance.useFunctionsEmulator("http://localhost", 5001);
      final host = defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2:8080'
          : 'localhost:8080';
      FirebaseFirestore.instance.settings =
          Settings(host: host, sslEnabled: false, persistenceEnabled: false);
    }
  }

  ThemeData _getAppTheme() => ThemeData(
        primaryColor: AppColors.primaryColor,
        backgroundColor: AppColors.baseBackgroundColor,
        appBarTheme: AppBarTheme(
            brightness: SchedulerBinding.instance?.window.platformBrightness),
      );
}
