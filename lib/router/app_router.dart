import 'package:flutter/widgets.dart';

abstract class AppRouter {
  void goEditPage(BuildContext context);

  void goRecognizePage(BuildContext context);

  static const splashPageRoutePath = '/';
  static const numberEditPageRoutePath = '/edit';
  static const numberRecognizePageRoutePath = '/recognize';
}
