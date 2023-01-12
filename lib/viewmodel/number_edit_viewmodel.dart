import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/model/current_year_win_numbers.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/usecase/load_numbers_usecase.dart';
import 'package:nengar/usecase/save_numbers_usecase.dart';

class NumberEditViewModel {
  late final NumbersRepository _numbersRepository;
  late final LoadNumbersUseCase _loadNumbersUseCase;
  late final SaveNumbersUseCase _saveNumbersUseCase;

  NumberEditViewModel(NumbersRepository numbersRepository) {
    _numbersRepository = numbersRepository;
    _loadNumbersUseCase = LoadNumbersUseCase(_numbersRepository);
    _saveNumbersUseCase = SaveNumbersUseCase(_numbersRepository);
  }

  final firstTextEditingController = useTextEditingController(text: '');

  final secondTextEditingController = useTextEditingController(text: '');

  final thirdPrimaryTextEditingController = useTextEditingController(text: '');

  final thirdSecondaryTextEditingController =
      useTextEditingController(text: '');

  final thirdTertiaryTextEditingController = useTextEditingController(text: '');

  void onBuild() {
    useEffectOnce(() {
      _onLoadNumbers();
      return null;
    });
  }

  void _onLoadNumbers() {
    _loadNumbersUseCase.execute().then((uiModel) {
      if (uiModel == WinNumbersUiModel.empty()) {
        firstTextEditingController.text = CurrentYearWinNumbers.first;
        secondTextEditingController.text = CurrentYearWinNumbers.second;
        thirdPrimaryTextEditingController.text =
            CurrentYearWinNumbers.thirdPrimary;
        thirdSecondaryTextEditingController.text =
            CurrentYearWinNumbers.thirdSecondary;
        thirdTertiaryTextEditingController.text =
            CurrentYearWinNumbers.thirdTertiary;
        return;
      }
      firstTextEditingController.text = uiModel.firstWinNumber;
      secondTextEditingController.text = uiModel.secondWinNumber;
      thirdPrimaryTextEditingController.text = uiModel.thirdPrimaryWinNumber;
      thirdSecondaryTextEditingController.text =
          uiModel.thirdSecondaryWinNumber;
      thirdTertiaryTextEditingController.text = uiModel.thirdTertiaryWinNumber;
    });
  }

  Future saveNumbers(Function showDialog) async {
    final winNumbersUiModel = WinNumbersUiModel(
        firstTextEditingController.text,
        secondTextEditingController.text,
        thirdPrimaryTextEditingController.text,
        thirdSecondaryTextEditingController.text,
        thirdTertiaryTextEditingController.text);
    await _saveNumbersUseCase.execute(
      winNumbersUiModel,
      () => showDialog(),
    );
  }
}
