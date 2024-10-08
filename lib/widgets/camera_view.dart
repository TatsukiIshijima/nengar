import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/main.dart';
import 'package:nengar/model/camera_permission_error.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/viewmodel/camera_viewmodel.dart';

import '../gen/colors.gen.dart';

/// https://github.com/bharat-biradar/Google-Ml-Kit-plugin/blob/master/packages/google_ml_kit/example/lib/vision_detector_views/text_detector_view.dart

class CameraView extends StatefulWidget {
  const CameraView({
    Key? key,
    required this.cameraViewModel,
    required this.onImage,
    this.customPaint,
    this.initialDirection = CameraLensDirection.back,
  }) : super(key: key);

  final CameraViewModel cameraViewModel;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  int _cameraIndex = -1;
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
      for (var i = 0; i < cameras.length; i++) {
        if (cameras[i].lensDirection == widget.initialDirection) {
          _cameraIndex = i;
          break;
        }
      }
    }

    if (_cameraIndex == -1) {
      return;
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
    final cameraPermissionError = widget.cameraViewModel.cameraPermissionError;
    if (cameraPermissionError != null) {
      return _CameraViewBody(
        children: [
          Center(
            child: _CameraPermissionErrorText(cameraPermissionError),
          ),
        ],
      );
    }

    if (_controller == null || _controller?.value.isInitialized == false) {
      return const _CameraViewBody(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: ColorName.primaryColor,
            ),
          ),
        ],
      );
    }

    final size = MediaQuery.of(context).size;
    // スクリーンやカメラ比によるスケールの計算
    // landscape として camera preview の size を受け取るので
    // 実際には size.aspectRatio / (1 / camera.aspectRatio) の計算になるが
    // portrait の計算なので以下になる
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    if (scale < 1) scale = 1 / scale;

    return _CameraViewBody(
      children: [
        Transform.scale(
          scale: scale,
          child: Center(
            child: CameraPreview(_controller!),
          ),
        ),
        if (widget.customPaint != null) widget.customPaint!
      ],
    );
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      _controller?.lockCaptureOrientation();
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream((image) => _processCameraImage(image));
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        widget.cameraViewModel.cameraPermissionError =
            CameraPermissionError.values.byName(e.code);
      }
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final camera = cameras[_cameraIndex];
    final rotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}

class _CameraPermissionErrorText extends StatelessWidget {
  const _CameraPermissionErrorText(
    this._error, {
    Key? key,
  }) : super(key: key);

  final CameraPermissionError _error;

  @override
  Widget build(BuildContext context) {
    var description = '';
    switch (_error) {
      case CameraPermissionError.CameraAccessDenied:
        description = AppLocalizations.of(context)!.cameraAccessDenied;
        break;
      case CameraPermissionError.CameraAccessDeniedWithoutPrompt:
        description =
            AppLocalizations.of(context)!.cameraAccessDeniedWithoutPrompt;
        break;
      case CameraPermissionError.CameraAccessRestricted:
        description = AppLocalizations.of(context)!.cameraAccessRestricted;
        break;
      case CameraPermissionError.AudioAccessDenied:
        description = AppLocalizations.of(context)!.audioAccessDenied;
        break;
      case CameraPermissionError.AudioAccessDeniedWithoutPrompt:
        description =
            AppLocalizations.of(context)!.audioAccessDeniedWithoutPrompt;
        break;
      case CameraPermissionError.AudioAccessRestricted:
        description = AppLocalizations.of(context)!.audioAccessRestricted;
        break;
    }
    return PlatformText(
      description,
      style: subTitle1.copyWith(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _CameraViewBody extends StatelessWidget {
  const _CameraViewBody({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: children,
      ),
    );
  }
}
