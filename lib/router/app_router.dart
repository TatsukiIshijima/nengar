import 'package:flutter/widgets.dart';

abstract class AppRouter {
  void goEditPage(BuildContext context);

  void goRecognizePage(BuildContext context, {bool forceUpdate = false});

  static const splashPageRoutePath = '/';
  static const numberEditPageRoutePath = '/edit';
  static const numberRecognizePageRoutePath = '/recognize';

  static const goEditRoutePath =
      '$numberRecognizePageRoutePath$numberEditPageRoutePath';

  static const forceUpdateQuery = 'update';
}
