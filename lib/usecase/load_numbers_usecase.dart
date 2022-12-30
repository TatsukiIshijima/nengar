import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';

class LoadNumbersUseCase {
  LoadNumbersUseCase(this._numbersRepository);

  final NumbersRepository _numbersRepository;

  Future<WinNumbersUiModel> execute() async {
    final numbersData = await _numbersRepository.load();
    if (numbersData == null) {
      return WinNumbersUiModel.empty();
    } else {
      return WinNumbersUiModel.from(numbersData);
    }
  }
}
