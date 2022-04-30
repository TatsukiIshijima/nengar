extension RegExpExtension on String {
  bool isNumber() {
    return RegExp(r'[0-9]{6}').hasMatch(this);
  }
}
