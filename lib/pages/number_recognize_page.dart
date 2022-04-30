import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';
import 'package:nengar/model/RecognizedText.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/widgets/camera_view.dart';
import 'package:nengar/widgets/number_detector_painter.dart';

class NumberRecognizePage extends StatefulWidget {
  const NumberRecognizePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumberRecognizeState();
}

class _NumberRecognizeState extends State<NumberRecognizePage> {
  TextDetectorV2 textDetector = GoogleMlKit.vision.textDetectorV2();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  @override
  void dispose() async {
    _canProcess = false;
    await textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: [
            CameraView(
              customPaint: _customPaint,
              onImage: ((inputImage) {
                recognizeTextFrom(inputImage);
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                color: const Color.fromRGBO(255, 255, 255, 0.7),
                // TODO:変数化
                child: const RecognizedWinResultSection(
                  comment: 'ざんねん...',
                  winResult: 'ハズレ',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recognizeTextFrom(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final recognisedText = await textDetector.processImage(
      inputImage,
      script: TextRecognitionOptions.DEVANAGIRI,
    );
    final recognizedText = recognisedText.toRecognizedText().filteredByNumber();
    final size = inputImage.inputImageData?.size;
    final rotation = inputImage.inputImageData?.imageRotation;
    if (size != null && rotation != null) {
      final painter = NumberDetectorPainter(recognizedText, size, rotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class RecognizedWinResultSection extends StatelessWidget {
  final String comment;
  final String winResult;

  const RecognizedWinResultSection({
    Key? key,
    required this.comment,
    required this.winResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          comment,
          textAlign: TextAlign.center,
          style: bodyText1,
        ),
        Text(
          winResult,
          textAlign: TextAlign.center,
          style: title1,
        ),
      ],
    );
  }
}
