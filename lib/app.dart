import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nengar/flavors.dart';
import 'package:nengar/pages/number_recognize_page.dart';

class App extends StatelessWidget {
  final CameraDescription camera;

  const App({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: F.title,
      theme: const CupertinoThemeData(),
      home: _flavorBanner(
        child: NumberRecognizePage(
          camera: camera,
        ),
        show: kDebugMode,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              child: child,
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
              textDirection: TextDirection.ltr,
            )
          : Container(
              child: child,
            );
}
