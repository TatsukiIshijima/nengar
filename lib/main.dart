import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:nengar/app.dart';
import 'package:nengar/flavors.dart';

List<CameraDescription> cameras = [];

Future<void> run(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  F.appFlavor = flavor;
  runApp(
    App(),
  );
}
