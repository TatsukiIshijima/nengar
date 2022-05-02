extension RegExpExtension on String {
  bool isSixDigitsNumber() {
    return RegExp(r'[0-9]{6}').hasMatch(this);
  }

  bool isFourDigitsNumber() {
    return RegExp(r'[0-9]{4}').hasMatch(this);
  }

  bool isTwoDigitsNumber() {
    return RegExp(r'[0-9]{2}').hasMatch(this);
  }
}
