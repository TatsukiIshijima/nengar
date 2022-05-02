import 'package:flutter/cupertino.dart';
import 'package:nengar/model/numbers_data.dart';
import 'package:nengar/model/third_win_numbers.dart';
import 'package:nengar/model/win_numbers.dart';
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

  Future<void> execute(
    String firstWinNumber,
    String secondWinNumber,
    String thirdPrimaryWinNumber,
    String thirdSecondaryWinNumber,
    String thirdTertiaryWinNumber,
  ) async {
    final thirdWinNumbers = ThirdWinNumbers(
        thirdPrimaryWinNumber, thirdSecondaryWinNumber, thirdTertiaryWinNumber);
    final winNumbers =
        WinNumbers(firstWinNumber, secondWinNumber, thirdWinNumbers);
    final numbersData = NumbersData(winNumbers, DateTime.now().toUtc());
    await _numbersRepository.save(numbersData);
    _appRouter.goRecognizePage(_context);
  }
}
