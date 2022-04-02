import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/widgets/camera_view.dart';

class NumberRecognizePage extends StatefulWidget {
  const NumberRecognizePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumberRecognizeState();
}

class _NumberRecognizeState extends State<NumberRecognizePage> {
  TextDetectorV2 textDetector = GoogleMlKit.vision.textDetectorV2();
  bool isBusy = false;

  @override
  void dispose() async {
    super.dispose();
    await textDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Text Detector',
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final recognisedText = await textDetector.processImage(
      inputImage,
      script: TextRecognitionOptions.DEVANAGIRI,
    );
    print('Found: ${recognisedText.blocks.length} textBlocks, '
        '${recognisedText.text} resText');
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
