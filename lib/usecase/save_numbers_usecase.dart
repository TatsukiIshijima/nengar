import 'package:flutter/cupertino.dart';
import 'package:nengar/model/numbers_data.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';

class SaveNumbersUseCase {
  SaveNumbersUseCase(
    this._context,
    this._appRouter,
    this._numbersRepository,
  );

  final BuildContext _context;
  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;

  Future<void> execute(WinNumbersUiModel winNumbersUiModel) async {
    final numbersData = NumbersData.from(winNumbersUiModel);
    await _numbersRepository.save(numbersData);
    _appRouter.goRecognizePage(_context);
  }
}
