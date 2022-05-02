import 'package:nengar/extension/RegExpExtension.dart';
import 'package:nengar/model/recognized_text.dart';
import 'package:nengar/model/win_type.dart';
import 'package:nengar/repository/numbers_repository.dart';

class JudgeNumbersUseCase {
  JudgeNumbersUseCase(this._numbersRepository);

  final NumbersRepository _numbersRepository;

  Future<WinType> execute(RecognizedText recognizeText) async {
    final localNumbersData = await _numbersRepository.load();
    final localFirstWinNumber =
        localNumbersData?.winNumbers.firstWinNumber ?? '';
    final localSecondWinNumber =
        localNumbersData?.winNumbers.secondWinNumber ?? '';
    final localThirdPrimaryWinNumber =
        localNumbersData?.winNumbers.thirdWinNumbers.primaryWinNumber ?? '';
    final localThirdSecondaryWinNumber =
        localNumbersData?.winNumbers.thirdWinNumbers.secondaryWinNumber ?? '';
    final localThirdTertiaryWinNumber =
        localNumbersData?.winNumbers.thirdWinNumbers.tertiaryWinNumber ?? '';

    if (localFirstWinNumber.isEmpty ||
        localSecondWinNumber.isEmpty ||
        localThirdPrimaryWinNumber.isEmpty ||
        localThirdSecondaryWinNumber.isEmpty ||
        localThirdTertiaryWinNumber.isEmpty) {
      return WinType.none;
    }

    final recognizedNumber = recognizeText.blocks.first.text;
    if (recognizedNumber.isEmpty || !recognizedNumber.isSixDigitsNumber()) {
      return WinType.none;
    }

    if (recognizedNumber == localFirstWinNumber) {
      return WinType.first;
    }
    if (recognizedNumber.substring(2).contains(localSecondWinNumber)) {
      return WinType.second;
    }
    if (recognizedNumber.substring(4).contains(localThirdPrimaryWinNumber) ||
        recognizedNumber.substring(4).contains(localThirdSecondaryWinNumber) ||
        recognizedNumber.substring(4).contains(localThirdTertiaryWinNumber)) {
      return WinType.third;
    }
    return WinType.other;
  }
}
