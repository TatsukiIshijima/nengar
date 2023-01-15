import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/usecase/load_numbers_usecase.dart';

class NumberLoadViewModel {
  late final NumbersRepository _numbersRepository;
  late final LoadNumbersUseCase _loadNumbersUseCase;

  NumberLoadViewModel(NumbersRepository numbersRepository) {
    _numbersRepository = numbersRepository;
    _loadNumbersUseCase = LoadNumbersUseCase(_numbersRepository);
  }

  final ValueNotifier<bool> _forceUpdateUseState = useState(false);

  final ValueNotifier<WinNumbersUiModel> _winNumbersUseState =
      useState(WinNumbersUiModel.empty());

  WinNumbersUiModel get winNumbersUiModel => _winNumbersUseState.value;

  bool isEmptyNumber() => winNumbersUiModel == WinNumbersUiModel.empty();

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
}
