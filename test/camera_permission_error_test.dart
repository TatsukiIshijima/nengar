import 'package:flutter_test/flutter_test.dart';
import 'package:nengar/model/camera_permission_error.dart';

void main() {
  group('CameraPermissionError', () {
    setUp(() {});

    test('byName', () {
      const code = "CameraAccessDenied";
      final error = CameraPermissionError.values.byName(code);
      expect(error, CameraPermissionError.CameraAccessDenied);
    });
  });
}
