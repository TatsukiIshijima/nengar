import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';
import 'package:nengar/model/recognized_text.dart' as model;
import 'package:nengar/model/win_type.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/usecase/judge_numbers_usecase.dart';
import 'package:nengar/widgets/camera_view.dart';
import 'package:nengar/widgets/number_detector_painter.dart';

class NumberRecognizePage extends StatelessWidget {
  const NumberRecognizePage(
    this._appRouter,
    this._numbersRepository, {
    Key? key,
  }) : super(key: key);

  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('年賀玉'),
        trailingActions: [
          IconButton(
            onPressed: () {
              // FIXME:go_routerのサブルート遷移だと認識画面のカメラが止まらないので対応必要
              GoRouter.of(context).go('/recognize/edit');
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: _RecognizePageBody(_numbersRepository),
      ),
    );
  }
}

class _RecognizePageBody extends HookWidget {
  const _RecognizePageBody(this._numbersRepository, {Key? key})
      : super(key: key);

  final NumbersRepository _numbersRepository;

  @override
  Widget build(BuildContext context) {
    final judgeUseCaseRef = useRef(JudgeNumbersUseCase(_numbersRepository));
    final commentUseState = useState('');
    final winResultUseState = useState('');

    return Stack(
      children: [
        _RecognizeCameraView(
          onRecognized: (model.RecognizedText recognizedText) async {
            // iterable の first が IterableElementError を返すので早期リターン
            if (recognizedText.blocks.isEmpty) {
              commentUseState.value = '';
              winResultUseState.value = '';
              return;
            }
            final winType = await judgeUseCaseRef.value.execute(recognizedText);
            if (winType == WinType.other) {
              commentUseState.value = 'ざんねん...';
            } else if (winType == WinType.none) {
              commentUseState.value = '';
            } else {
              commentUseState.value = 'おめでとうございます！';
            }
            winResultUseState.value = winType.text;
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Text(
                    'カメラをくじ番号にかざしてください',
                    textAlign: TextAlign.center,
                    style: subTitle2,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    child: _RecognizedWinResultSection(
                      comment: commentUseState.value,
                      winResult: winResultUseState.value,
                    ),
                  ),
                ),
              ],
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

  final Function(model.RecognizedText recognizedText) onRecognized;

  @override
  State<StatefulWidget> createState() => _RecognizeCameraViewState();
}

class _RecognizeCameraViewState extends State<_RecognizeCameraView> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  @override
  void dispose() async {
    _canProcess = false;
    await _textRecognizer.close();
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
    final recognisedText = await _textRecognizer.processImage(inputImage);
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
    model.RecognizedText recognizedText,
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
