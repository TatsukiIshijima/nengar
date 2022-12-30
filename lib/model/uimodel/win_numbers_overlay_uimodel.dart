import 'package:nengar/model/numbers_data.dart';

class WinNumbersOverlayUiModel {
  final String firstWinNumber;
  final String secondWinNumber;
  final String thirdPrimaryWinNumber;
  final String thirdSecondaryWinNumber;
  final String thirdTertiaryWinNumber;

  WinNumbersOverlayUiModel(
    this.firstWinNumber,
    this.secondWinNumber,
    this.thirdPrimaryWinNumber,
    this.thirdSecondaryWinNumber,
    this.thirdTertiaryWinNumber,
  );

  factory WinNumbersOverlayUiModel.from(NumbersData numbersData) {
    final winNumbers = numbersData.winNumbers;
    final thirdWinNumbers = winNumbers.thirdWinNumbers;
    return WinNumbersOverlayUiModel(
      winNumbers.firstWinNumber,
      winNumbers.secondWinNumber,
      thirdWinNumbers.primaryWinNumber,
      thirdWinNumbers.secondaryWinNumber,
      thirdWinNumbers.tertiaryWinNumber,
    );
  }

  factory WinNumbersOverlayUiModel.empty() {
    return WinNumbersOverlayUiModel(
      '',
      '',
      '',
      '',
      '',
    );
  }
}
