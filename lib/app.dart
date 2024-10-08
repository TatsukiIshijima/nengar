import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nengar/datasource/numbers_datasource_impl.dart';
import 'package:nengar/pages/number_edit_page.dart';
import 'package:nengar/pages/number_recognize_page.dart';
import 'package:nengar/pages/splash_page.dart';
import 'package:nengar/repository/numbers_repository_impl.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/router/app_router_impl.dart';
import 'package:nengar/theme.dart';

class App extends HookWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouterRef = useRef(AppRouterImpl());
    final numbersDataSourceRef = useRef(NumbersDataSourceImpl());
    final numbersRepositoryRef =
        useRef(NumbersRepositoryImpl(numbersDataSourceRef.value));

    const env = String.fromEnvironment('FLAVOR');

    final splashRoute = GoRoute(
      path: AppRouter.splashPageRoutePath,
      builder: (context, state) => SplashPage(
        appRouterRef.value,
        numbersRepositoryRef.value,
      ),
    );
    final numberEditRoute = GoRoute(
      path: AppRouter.numberEditPageRoutePath,
      builder: (context, state) => NumberEditPage(
        appRouterRef.value,
        numbersRepositoryRef.value,
      ),
    );
    final numberRecognizeRoute = GoRoute(
      path: AppRouter.numberRecognizePageRoutePath,
      builder: (context, state) {
        final forceUpdateQuery =
            state.uri.queryParameters[AppRouter.forceUpdateQuery] ?? 'false';
        final forceUpdate = forceUpdateQuery.toLowerCase() == 'true';
        return NumberRecognizePage(
          appRouterRef.value,
          numbersRepositoryRef.value,
          forceUpdate,
        );
      },
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) =>
              NumberEditPage(appRouterRef.value, numbersRepositoryRef.value),
        ),
      ],
    );

    final router = GoRouter(
      routes: [
        splashRoute,
        numberEditRoute,
        numberRecognizeRoute,
      ],
      initialLocation: AppRouter.splashPageRoutePath,
    );

    return Theme(
      data: nengarMaterialLightTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(
          iosUsesMaterialWidgets: true,
          iosUseZeroPaddingForAppbarPlatformIcon: true,
        ),
        builder: (context) => PlatformApp(
          title: env,
          locale: const Locale('ja'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          material: (_, __) => MaterialAppData(
            theme: nengarMaterialLightTheme,
            darkTheme: nengarMaterialDarkTheme,
            // FIXME:ダークモード対応
            themeMode: ThemeMode.light,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: nengarCupertinoLightTheme,
          ),
          home: _flavorBanner(
            child: PlatformApp.router(
              routerConfig: router,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            ),
            show: kDebugMode,
          ),
        ),
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) {
    const env = String.fromEnvironment('FLAVOR');
    return show
        ? Banner(
            child: child,
            location: BannerLocation.topStart,
            message: env,
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
          )
        : Container(
            child: child,
          );
  }
}
