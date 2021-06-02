import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'app/router.router.dart';

void main() async {
  await setupLocator();

  runApp(
    DairoApp(),
  );
}

class DairoApp extends StatefulWidget {
  @override
  _DairoAppState createState() => _DairoAppState();
}

class _DairoAppState extends State<DairoApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateRoute: StackedRouter().onGenerateRoute,
        theme: _getAppTheme(),
        navigatorKey: StackedService.navigatorKey,
        debugShowCheckedModeBanner: false,
      );

  ThemeData _getAppTheme() => ThemeData(
        primaryColor: AppColors.white,
        backgroundColor: AppColors.baseBackgroundColor,
      );
}
