import 'package:flutter/widgets.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String get overflow => Characters(this)
      .replaceAll(Characters(''), Characters('\u{200B}'))
      .toString();
}

validateUrl(String str) {
  final uri = Uri.tryParse(str);
  return uri != null && uri.hasAbsolutePath && uri.scheme.startsWith('http');
}
