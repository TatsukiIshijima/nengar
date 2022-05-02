import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';

class SplashPage extends HookWidget {
  const SplashPage({
    Key? key,
    required this.appRouter,
    required this.numbersRepository,
  }) : super(key: key);

  final AppRouter appRouter;
  final NumbersRepository numbersRepository;

  void initialize(BuildContext context) {
    Timer(
      const Duration(milliseconds: 2000),
      () async {
        final numbersData = await numbersRepository.load();
        if (numbersData == null) {
          appRouter.goEditPage(context);
        } else {
          appRouter.goRecognizePage(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('FLAVOR');

    useEffectOnce(() {
      initialize(context);
    });

    return PlatformScaffold(
      body: Center(
        child: PlatformText(
          'Splash $env',
        ),
      ),
    );
  }
}
