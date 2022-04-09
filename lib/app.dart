import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nengar/pages/number_recognize_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const env = String.fromEnvironment('FLAVOR');
    return MaterialApp(
      title: env,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _flavorBanner(
        child: NumberRecognizePage(),
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
