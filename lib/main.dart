import 'dart:async';

import 'package:ansicolor/ansicolor.dart';
import 'package:country_codes/country_codes.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'app/router.router.dart';

void main() async {
  ansiColorDisabled = false;
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
      setState(() => _initialized = true);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  ThemeData _getAppTheme() => ThemeData(
        primaryColor: AppColors.primaryColor,
        backgroundColor: AppColors.baseBackgroundColor,
      );
}
