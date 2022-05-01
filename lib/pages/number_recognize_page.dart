import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';
import 'package:nengar/model/RecognizedText.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/widgets/camera_view.dart';
import 'package:nengar/widgets/number_detector_painter.dart';

class NumberRecognizePage extends StatelessWidget {
  const NumberRecognizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: SafeArea(
        child: RecognizePageBody(),
      ),
    );
  }
}

class RecognizePageBody extends StatefulWidget {
  const RecognizePageBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RecognizePageState();
}

class RecognizePageState extends State<RecognizePageBody> {
  final TextDetectorV2 _textDetector = GoogleMlKit.vision.textDetectorV2();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  @override
  void dispose() async {
    _canProcess = false;
    await _textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraView(
          customPaint: _customPaint,
          onImage: ((inputImage) {
            _recognizeProcess(inputImage);
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
    );
  }

  Future<void> _recognizeProcess(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;

    _isBusy = true;
    await _paintRecognizedResultIfNeed(inputImage);
    _isBusy = false;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _paintRecognizedResultIfNeed(InputImage inputImage) async {
    final recognisedText = await _textDetector.processImage(
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
