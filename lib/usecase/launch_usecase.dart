import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';

class LaunchUseCase {
  LaunchUseCase(
    this._context,
    this._appRouter,
    this._numbersRepository,
  );

  final BuildContext _context;
  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;

  Future<void> execute() async {
    final numbersData = await _numbersRepository.load();
    Timer(const Duration(milliseconds: 1500), () {
      if (numbersData == null) {
        _appRouter.goEditPage(_context);
        return;
      }
      _appRouter.goRecognizePage(_context);
    });
  }
}
