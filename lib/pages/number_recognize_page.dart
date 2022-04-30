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
  String? _text;
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
        child: CameraView(
          customPaint: _customPaint,
          text: _text,
          onImage: ((inputImage) {
            recognizeTextFrom(inputImage);
          }),
        ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.max,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     CameraView(
        //       onImage: (inputImage) {
        //         recognizeTextFrom(inputImage);
        //       },
        //     ),
        //     Expanded(
        //       child: Padding(
        //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.max,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Padding(
        //               padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
        //               child: RecognizedNumberResultSection(
        //                 resultText: recognizedText,
        //               ),
        //             ),
        //             Expanded(
        //               child: Padding(
        //                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        //                 child: RecognizedWinResultSection(
        //                   comment: 'ざんねん...',
        //                   winResult: 'ハズレ',
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Future<void> recognizeTextFrom(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
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
      _text = 'Recognized text:\n\n${recognizedText.text}';
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class RecognizedNumberResultSection extends StatelessWidget {
  final String resultText;

  const RecognizedNumberResultSection({
    Key? key,
    required this.resultText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Text(
            '認識結果',
            style: subTitle1,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: CupertinoDynamicColor.withBrightness(
                color: Colors.black26,
                darkColor: Colors.white,
              ),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
            child: Text(
              resultText,
              textAlign: TextAlign.center,
              style: title1,
            ),
          ),
        ),
      ],
    );
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
