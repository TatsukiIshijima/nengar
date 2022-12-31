import 'package:flutter/cupertino.dart';
import 'package:nengar/model/numbers_data.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';

class SaveNumbersUseCase {
  SaveNumbersUseCase(this._numbersRepository);

  final NumbersRepository _numbersRepository;

  Future<void> execute(
    WinNumbersUiModel winNumbersUiModel,
    VoidCallback onSuccess,
  ) async {
    final numbersData = NumbersData.from(winNumbersUiModel);
    await _numbersRepository.save(numbersData);
    onSuccess();
  }
}
