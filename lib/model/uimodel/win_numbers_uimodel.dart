import 'package:nengar/model/numbers_data.dart';

class WinNumbersUiModel {
  final String firstWinNumber;
  final String secondWinNumber;
  final String thirdPrimaryWinNumber;
  final String thirdSecondaryWinNumber;
  final String thirdTertiaryWinNumber;

  WinNumbersUiModel(
    this.firstWinNumber,
    this.secondWinNumber,
    this.thirdPrimaryWinNumber,
    this.thirdSecondaryWinNumber,
    this.thirdTertiaryWinNumber,
  );

  factory WinNumbersUiModel.from(NumbersData numbersData) {
    final winNumbers = numbersData.winNumbers;
    final thirdWinNumbers = winNumbers.thirdWinNumbers;
    return WinNumbersUiModel(
      winNumbers.firstWinNumber,
      winNumbers.secondWinNumber,
      thirdWinNumbers.primaryWinNumber,
      thirdWinNumbers.secondaryWinNumber,
      thirdWinNumbers.tertiaryWinNumber,
    );
  }

  factory WinNumbersUiModel.empty() {
    return WinNumbersUiModel(
      '',
      '',
      '',
      '',
      '',
    );
  }
}
