import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nengar/model/recognized_text.dart' as model;
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/model/uimodel/win_result_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/usecase/judge_numbers_usecase.dart';
import 'package:nengar/usecase/load_numbers_usecase.dart';

class NumberRecognizeViewModel {
  late final NumbersRepository _numbersRepository;
  late final LoadNumbersUseCase _loadNumbersUseCase;
  late final JudgeNumbersUseCase _judgeNumbersUseCase;

  NumberRecognizeViewModel(NumbersRepository numbersRepository) {
    _numbersRepository = numbersRepository;
    _loadNumbersUseCase = LoadNumbersUseCase(_numbersRepository);
    _judgeNumbersUseCase = JudgeNumbersUseCase(_numbersRepository);
  }

  final ValueNotifier<bool> _forceUpdateUseState = useState(false);

  bool get forceUpdate => _forceUpdateUseState.value;

  final ValueNotifier<bool> _isEditModeUseState = useState(false);

  bool get isEditMode => _isEditModeUseState.value;

  set isEditMode(value) {
    _isEditModeUseState.value = value;
  }

  final ValueNotifier<WinResultUiModel> _winResultUseState =
      useState(WinResultUiModel.empty());

  WinResultUiModel get winResultUiModel => _winResultUseState.value;

  final ValueNotifier<WinNumbersUiModel> _winNumbersUseState =
      useState(WinNumbersUiModel.empty());

  WinNumbersUiModel get winNumbersUiModel => _winNumbersUseState.value;

  void onBuild(bool forceUpdate) {
    _changeForceUpdateFlag(forceUpdate);

    useEffect(() {
      _onLoadNumbers();
      return;
    }, [_forceUpdateUseState.value]);
  }

  void _changeForceUpdateFlag(bool isOn) {
    _forceUpdateUseState.value = isOn;
  }

  void _onLoadNumbers() {
    _loadNumbersUseCase.execute().then((uiModel) {
      _winNumbersUseState.value = uiModel;
    });
  }

  Future onRecognize(model.RecognizedText recognizedText) async {
    final winType = await _judgeNumbersUseCase.execute(recognizedText);
    _winResultUseState.value = WinResultUiModel.from(winType);
  }
}
