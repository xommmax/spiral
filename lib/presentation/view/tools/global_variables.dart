import 'package:flutter/cupertino.dart';

getScreenHeight(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final padding = MediaQuery.of(context).padding;
  final realHeight = height - padding.top;
  return realHeight - getBottomNavBarHeight(context);
}

double getBottomNavBarHeight(BuildContext context) =>
    63 + MediaQuery.of(context).padding.bottom;
