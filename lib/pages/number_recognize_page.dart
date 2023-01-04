import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';
import 'package:nengar/model/recognized_text.dart' as model;
import 'package:nengar/model/uimodel/win_result_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/viewmodel/number_recognize_viewmodel.dart';
import 'package:nengar/widgets/background.dart';
import 'package:nengar/widgets/camera_view.dart';
import 'package:nengar/widgets/number_detector_painter.dart';
import 'package:nengar/widgets/win_numbers_overlay.dart';

class NumberRecognizePage extends HookWidget {
  const NumberRecognizePage(
    this._appRouter,
    this._numbersRepository,
    this._forceUpdate, {
    Key? key,
  }) : super(key: key);

  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;
  final bool _forceUpdate;

  @override
  Widget build(BuildContext context) {
    final viewModelRef = useRef(NumberRecognizeViewModel(_numbersRepository));

    viewModelRef.value.onBuild(_forceUpdate);

    useEffect(
      () {
        viewModelRef.value.isEditMode = _appRouter
            .location(context)
            .contains(AppRouter.numberEditPageRoutePath);
        return null;
      },
      [_appRouter.location(context)],
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(AppLocalizations.of(context)!.appName),
        trailingActions: [
          IconButton(
            onPressed: () {
              // FIXME:go_routerのサブルート遷移だと認識画面のカメラが止まらないので対応必要
              _appRouter.goEditPage(context);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: _RecognizePageBody(viewModelRef.value),
      ),
    );
  }
}

class _RecognizePageBody extends StatelessWidget {
  const _RecognizePageBody(
    this._numberRecognizeViewModel, {
    Key? key,
  }) : super(key: key);

  final NumberRecognizeViewModel _numberRecognizeViewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _RecognizeCameraView(
          onRecognized: (model.RecognizedText recognizedText) async {
            _numberRecognizeViewModel.onRecognize(recognizedText);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.black.withAlpha(64),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WinNumbersOverlay(
                        uiModel: _numberRecognizeViewModel.winNumbersUiModel,
                      ),
                      PlatformText(
                        AppLocalizations.of(context)!
                            .recognizePageCameraOperationHint,
                        textAlign: TextAlign.center,
                        style: subTitle1.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: _RecognizedWinResultSection(
                    uiModel: _numberRecognizeViewModel.winResultUiModel,
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
  final WinResultUiModel uiModel;

  const _RecognizedWinResultSection({
    Key? key,
    required this.uiModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: uiModel.resultImage != null
            ? Image(
                image: uiModel.resultImage!,
                fit: BoxFit.fitHeight,
              )
            : Container(),
      ),
    );
  }
}
