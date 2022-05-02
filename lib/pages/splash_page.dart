import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/usecase/launch_usecase.dart';

class SplashPage extends HookWidget {
  const SplashPage(
    this._appRouter,
    this._numbersRepository, {
    Key? key,
  }) : super(key: key);

  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;

  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('FLAVOR');

    final launchUseCaseRef =
        useRef(LaunchUseCase(context, _appRouter, _numbersRepository));

    useEffectOnce(() {
      launchUseCaseRef.value.execute();
      return null;
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
