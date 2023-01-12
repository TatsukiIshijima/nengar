import 'package:flutter_test/flutter_test.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';

void main() {
  group('WinNumbersUiModel', () {
    setUp(() {});

    test('equal', () {
      final emptyWinNumbersUiModel = WinNumbersUiModel.empty();
      expect(emptyWinNumbersUiModel == WinNumbersUiModel.empty(), true);

      final actualWinNumbersUiModel =
          WinNumbersUiModel('123456', '1234', '12', '34', '56');
      var expectWinNumbersUiModel =
          WinNumbersUiModel('123456', '1234', '12', '34', '56');
      expect(actualWinNumbersUiModel == expectWinNumbersUiModel, true);

      expectWinNumbersUiModel =
          WinNumbersUiModel('123456', '1234', '12', '34', '57');
      expect(actualWinNumbersUiModel == expectWinNumbersUiModel, false);
    });
  });
}
