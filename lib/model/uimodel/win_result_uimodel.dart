import 'package:nengar/model/win_type.dart';

class WinResultUiModel {
  final String commentText;
  final String winTypeText;

  WinResultUiModel(
    this.commentText,
    this.winTypeText,
  );

  factory WinResultUiModel.empty() {
    return WinResultUiModel('', '');
  }

  factory WinResultUiModel.from(WinType winType) {
    String commentText = '';
    if (winType == WinType.first ||
        winType == WinType.second ||
        winType == WinType.third) {
      commentText = 'おめでとうございます！';
    } else if (winType == WinType.other) {
      commentText = 'ざんねん...';
    }
    return WinResultUiModel(
      commentText,
      winType.text,
    );
  }
}
