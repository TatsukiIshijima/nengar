import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/main.dart';
import 'package:nengar/widgets/camera_overlay_shape.dart';

/**
 * https://github.com/bharat-biradar/Google-Ml-Kit-plugin/blob/master/packages/google_ml_kit/example/lib/vision_detector_views/text_detector_view.dart
 * https://aakira.app/blog/2021/02/image-overlay/
 */

class CameraView extends StatefulWidget {
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  CameraView({
    Key? key,
    required this.onImage,
    this.customPaint,
    this.initialDirection = CameraLensDirection.back,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  @override
  void initState() {
    super.initState();

    if (cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
            element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection,
        ),
      );
    }

    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return AspectRatio(
      aspectRatio: _calculateAspectRatio(),
      child: Stack(
        children: [
          ClipRect(
            child: Transform.scale(
              scale: _controller.value.aspectRatio,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1 / _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ),
            ),
          ),
          Container(
            decoration: const ShapeDecoration(
              shape: CameraOverlayShape(
                borderColor: Colors.white,
                borderLength: 32,
                borderRadius: 12,
                borderWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 端末の短辺に対してx倍したアスペクト比
  double _calculateAspectRatio() {
    final shortSide = _controller.value.previewSize?.height ?? 0;
    final longSide = shortSide * 1.25;
    return shortSide / longSide;
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller.startImageStream((image) => _processCameraImage(image));
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller.stopImageStream();
    await _controller.dispose();
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          width: plane.width,
          height: plane.height,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      inputImageData: inputImageData,
    );

    widget.onImage(inputImage);
  }
}
