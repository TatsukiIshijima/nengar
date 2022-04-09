import 'package:flutter/cupertino.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('FLAVOR');
    return CupertinoPageScaffold(
      child: Center(
        child: Text(
          'Splash ${env}',
        ),
      ),
    );
  }
}
