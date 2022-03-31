import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:nengar/app.dart';
import 'package:nengar/flavors.dart';

Future<void> run(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  F.appFlavor = flavor;
  runApp(
    App(
      camera: firstCamera,
    ),
  );
}
