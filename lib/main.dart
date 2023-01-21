import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:nengar/app.dart';
import 'package:nengar/log.dart';
import 'package:package_info_plus/package_info_plus.dart';

List<CameraDescription> cameras = [];

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  Log.logger.d(
      "PackageInfo: appName=$appName, packageName=$packageName, version=$version, buildNumber=$buildNumber");

  cameras = await availableCameras();

  runApp(
    App(),
  );
}

void main() {
  run();
}
