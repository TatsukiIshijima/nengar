import 'package:flutter/cupertino.dart';
import 'package:nengar/flavors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(
          'Splash ${F.title}',
        ),
      ),
    );
  }
}
