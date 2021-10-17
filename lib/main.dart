import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:country_codes/country_codes.dart';
import 'package:dairo/data/db/repository/user_local_repository.dart';
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final AnalyticsRepository analyticsRepository =
      locator<AnalyticsRepository>();
  final UserLocalRepository _localUserRepository =
      locator<UserLocalRepository>();

  @override
  _DairoAppState createState() => _DairoAppState();
}

class _DairoAppState extends State<DairoApp> {
  bool _initialized = false;
  bool _isCurrentUserExist = false;

  @override
  void initState() {
    initializeApp();
    widget.analyticsRepository.logAppOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return SizedBox.shrink();
    }
    final ThemeData theme = _getAppTheme();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: AppColors.darkAccentColor,
    ));

    return MaterialApp(
      theme: theme.copyWith(
          colorScheme:
              theme.colorScheme.copyWith(secondary: AppColors.accentColor)),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute:
          _isCurrentUserExist ? Routes.mainView : Routes.authSplashView,
      navigatorObservers: [widget.analyticsRepository.getObserver()],
      navigatorKey: StackedService.navigatorKey,
    );
  }

  void initializeApp() async {
    await initializeFlutterFire();
    await initializeUser();
    setState(() => _initialized = true);
  }

  Future<void> initializeFlutterFire() async {
    await Firebase.initializeApp();
    await _setupLocalFirebaseEnvironment();
  }

  Future<void> initializeUser() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      _isCurrentUserExist = false;
    } else {
      var firebaseUserId = firebaseUser.uid;
      var localUser = await widget._localUserRepository.getUser(firebaseUserId);
      _isCurrentUserExist = localUser != null;
    }
  }

  Future<void> _setupLocalFirebaseEnvironment() async {
    if (ENV.useFirebaseEmulator) {
      await FirebaseAuth.instance.useEmulator("http://localhost:9099");
      FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
      await FirebaseStorage.instance.useStorageEmulator("localhost", 9199);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    }
  }

  ThemeData _getAppTheme() => ThemeData.dark().copyWith(
        primaryColor: AppColors.darkAccentColor,
        backgroundColor: AppColors.baseBackgroundColor,
        scaffoldBackgroundColor: AppColors.baseBackgroundColor,
        bottomAppBarColor: AppColors.darkAccentColor,
        toggleableActiveColor: AppColors.accentColor,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: AppColors.white),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: AppColors.white, //change your color here
            ),
            color: AppColors.darkAccentColor,
            systemOverlayStyle: SystemUiOverlayStyle.light),
      );
}
