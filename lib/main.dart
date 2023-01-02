import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:nengar/app.dart';

List<CameraDescription> cameras = [];

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(
    App(),
  );
}

void main() {
  run();
}
