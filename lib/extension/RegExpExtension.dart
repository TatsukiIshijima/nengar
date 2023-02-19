extension RegExpExtension on String {
  bool isSixDigitsNumber() {
    return RegExp(r'^\d{6}$').hasMatch(this);
  }

  bool isFourDigitsNumber() {
    return RegExp(r'^\d{4}$').hasMatch(this);
  }

  bool isTwoDigitsNumber() {
    return RegExp(r'^\d{2}$').hasMatch(this);
  }
}
