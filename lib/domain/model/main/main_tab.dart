import 'package:dairo/presentation/res/strings.dart';
import 'package:flutter/material.dart';

class MainTab {
  final int index;
  final String title;
  final IconData icon;

  const MainTab(this.index, this.title, this.icon);
}

const mainTabs = [
  MainTab(0, Strings.home, Icons.home),
  MainTab(1, Strings.explore, Icons.explore),
];
