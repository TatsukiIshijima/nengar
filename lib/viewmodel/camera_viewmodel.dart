import 'package:nengar/model/camera_permission_error.dart';

class CameraViewModel {
  CameraPermissionError? _cameraPermissionError;

  set cameraPermissionError(value) {
    _cameraPermissionError = value;
  }

  CameraPermissionError? get cameraPermissionError => _cameraPermissionError;
}
