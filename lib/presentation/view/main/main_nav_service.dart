import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MainNavService {
  VoidCallback? _goToExploreCallback;
  VoidCallback? _homeDoubleClickCallback;

  void goToExplore() {
    _goToExploreCallback?.call();
  }

  void onHomeDoubleClick() {
    _homeDoubleClickCallback?.call();
  }

  set homeDoubleClickCallback(VoidCallback value) =>
      _homeDoubleClickCallback = value;

  set goToExploreCallback(VoidCallback value) => _goToExploreCallback = value;
}
