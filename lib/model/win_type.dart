enum WinType {
  first,
  second,
  third,
  other,
  none,
}

extension WinTypeExt on WinType {
  String get text {
    switch (this) {
      case WinType.first:
        return '1当賞';
      case WinType.second:
        return '2当賞';
      case WinType.third:
        return '3当賞';
      case WinType.other:
        return 'ハズレ';
      case WinType.none:
        return '';
    }
  }
}
