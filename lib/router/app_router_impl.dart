import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nengar/router/app_router.dart';

class AppRouterImpl extends AppRouter {
  @override
  void goEditPage(BuildContext context) {
    GoRouter.of(context).go(AppRouter.numberEditPageRoutePath);
  }

  @override
  void goRecognizePage(BuildContext context) {
    GoRouter.of(context).go(AppRouter.numberRecognizePageRoutePath);
  }
}
