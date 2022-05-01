import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';
import 'package:nengar/model/recognized_text.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/widgets/camera_view.dart';
import 'package:nengar/widgets/number_detector_painter.dart';

class NumberRecognizePage extends StatelessWidget {
  const NumberRecognizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: SafeArea(
        child: _RecognizePageBody(),
      ),
    );
  }
}

class _RecognizePageBody extends HookWidget {
  const _RecognizePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recognizeUseState = useState('');

    return Stack(
      children: [
        _RecognizeCameraView(
          onRecognized: (RecognizedText recognizedText) {
            // iterable の first が IterableElementError を返すので早期リターン
            if (recognizedText.blocks.isEmpty) {
              recognizeUseState.value = '';
              return;
            }
            recognizeUseState.value = recognizedText.blocks.first.text;
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            child: _RecognizedWinResultSection(
              comment: recognizeUseState.value,
              // TODO:判定
              winResult: 'ハズレ',
            ),
          ),
        ),
      ],
    );
  }
}

class _RecognizeCameraView extends StatefulWidget {
  const _RecognizeCameraView({
    Key? key,
    required this.onRecognized,
  }) : super(key: key);

  final Function(RecognizedText recognizedText) onRecognized;

  @override
  State<StatefulWidget> createState() => _RecognizeCameraViewState();
}

class _RecognizeCameraViewState extends State<_RecognizeCameraView> {
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
    return CameraView(
      customPaint: _customPaint,
      onImage: ((inputImage) {
        _recognizeProcess(inputImage);
      }),
    );
  }

  Future<void> _recognizeProcess(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;

    _isBusy = true;
    final recognisedText = await _textDetector.processImage(
      inputImage,
      script: TextRecognitionOptions.DEVANAGIRI,
    );
    final recognizedText = recognisedText.toRecognizedText().filteredByNumber();
    _paintRecognizedResultIfNeed(inputImage, recognizedText);
    _isBusy = false;

    if (mounted) {
      setState(() {
        if (_customPaint != null) {
          widget.onRecognized(recognizedText);
        }
      });
    }
  }

  void _paintRecognizedResultIfNeed(
    InputImage inputImage,
    RecognizedText recognizedText,
  ) {
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

class _RecognizedWinResultSection extends StatelessWidget {
  final String comment;
  final String winResult;

  const _RecognizedWinResultSection({
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
