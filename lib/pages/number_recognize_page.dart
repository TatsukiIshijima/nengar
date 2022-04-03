import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/text_style.dart';
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
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CameraView(
              onImage: (inputImage) {
                processImage(inputImage);
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: RecognizedNumberResultSection(
                        resultText: '123456',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: RecognizedWinResultSection(
                          comment: 'ざんねん...',
                          winResult: 'ハズレ',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
