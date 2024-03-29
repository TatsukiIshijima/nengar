import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/gen/assets.gen.dart';
import 'package:nengar/gen/colors.gen.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/usecase/launch_usecase.dart';
import 'package:nengar/widgets/background.dart';

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
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.8,
                alignment: FractionalOffset.center,
                child: Image(
                  image: Assets.image.splashImg.provider(),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                AppLocalizations.of(context)?.appName ?? '',
                style: const TextStyle(
                  color: ColorName.primaryColor,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
