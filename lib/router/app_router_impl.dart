import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nengar/router/app_router.dart';

class AppRouterImpl extends AppRouter {
  @override
  void goEditPage(BuildContext context) {
    GoRouter.of(context).go(AppRouter.goEditRoutePath);
  }

  @override
  void goRecognizePage(BuildContext context, {bool forceUpdate = false}) {
    GoRouter.of(context).go(
        '${AppRouter.numberRecognizePageRoutePath}?${AppRouter.forceUpdateQuery}=$forceUpdate');
  }

  @override
  String location(BuildContext context) => GoRouter.of(context).location;
}
