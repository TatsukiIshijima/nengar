import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nengar/widgets/camera_view.dart';

class NumberRecognizePage extends StatefulWidget {
  const NumberRecognizePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumberRecognizeState();
}

class _NumberRecognizeState extends State<NumberRecognizePage> {
  // late CustomPaint customPaint;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
        title: 'Text Detector',
        // customPaint: customPaint,
        onImage: (inputImage) {});
  }
}
