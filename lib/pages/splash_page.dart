import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/usecase/launch_usecase.dart';

class SplashPage extends HookWidget {
  SplashPage({
    Key? key,
    required this.appRouter,
    required this.numbersRepository,
  }) : super(key: key);

  final AppRouter appRouter;
  final NumbersRepository numbersRepository;

  late final LaunchUseCase _launchUseCase;

  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('FLAVOR');

    useEffectOnce(() {
      _launchUseCase = LaunchUseCase(context, appRouter, numbersRepository);
      _launchUseCase.execute();
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
