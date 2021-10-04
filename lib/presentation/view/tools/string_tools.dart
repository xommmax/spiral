extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

validateUrl(String str) {
  final uri = Uri.tryParse(str);
  return uri != null && uri.hasAbsolutePath && uri.scheme.startsWith('http');
}
