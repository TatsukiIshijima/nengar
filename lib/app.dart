import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:go_router/go_router.dart';
import 'package:nengar/datasource/numbers_datasouce.dart';
import 'package:nengar/datasource/numbers_datasource_impl.dart';
import 'package:nengar/pages/number_edit_page.dart';
import 'package:nengar/pages/number_recognize_page.dart';
import 'package:nengar/pages/splash_page.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/router/app_router_impl.dart';

class App extends HookWidget {
  App({Key? key}) : super(key: key);

  late AppRouter _appRouter;
  late NumbersDataSource _numbersDataSource;

  @override
  Widget build(BuildContext context) {
    useEffectOnce(() {
      _appRouter = AppRouterImpl();
      _numbersDataSource = NumbersDataSourceImpl();
    });

    const env = String.fromEnvironment('FLAVOR');

    final splashRoute = GoRoute(
      path: AppRouter.splashPageRoutePath,
      builder: (context, state) => SplashPage(
        appRouter: _appRouter,
        numbersDataSource: _numbersDataSource,
      ),
    );
    final numberEditRoute = GoRoute(
      path: AppRouter.numberEditPageRoutePath,
      builder: (context, state) => NumberEditPage(),
    );
    final numberRecognizeRoute = GoRoute(
        path: AppRouter.numberRecognizePageRoutePath,
        builder: (context, state) => NumberRecognizePage(),
        routes: [
          // TODO:共通化&パス設計
          GoRoute(
            path: 'edit',
            builder: (context, state) => NumberEditPage(),
          ),
        ]);

    final _router = GoRouter(
      routes: [
        splashRoute,
        numberEditRoute,
        numberRecognizeRoute,
      ],
      initialLocation: AppRouter.splashPageRoutePath,
    );

    return PlatformApp(
      title: env,
      home: _flavorBanner(
        child: PlatformApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        ),
        show: kDebugMode,
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
