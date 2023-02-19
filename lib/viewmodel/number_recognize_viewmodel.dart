import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';
import 'package:nengar/model/recognized_text.dart' as model;
import 'package:nengar/model/uimodel/win_result_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/usecase/judge_numbers_usecase.dart';
import 'package:nengar/widgets/number_detector_painter.dart';

class NumberRecognizeViewModel {
  late final NumbersRepository _numbersRepository;
  late final JudgeNumbersUseCase _judgeNumbersUseCase;

  NumberRecognizeViewModel(NumbersRepository numbersRepository) {
    _numbersRepository = numbersRepository;
    _judgeNumbersUseCase = JudgeNumbersUseCase(_numbersRepository);
  }

  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);

  final ValueNotifier<bool> _canProcessUseState = useState(true);

  final ValueNotifier<bool> _isBusyUseState = useState(false);

  final ValueNotifier<InputImage?> _inputImageUseState = useState(null);

  set inputImage(value) {
    _inputImageUseState.value = value;
  }

  final ValueNotifier<CustomPaint?> _customPaintUseState = useState(null);

  CustomPaint? get customPaint => _customPaintUseState.value;

  final ValueNotifier<bool> _isEditModeUseState = useState(false);

  set isEditMode(value) {
    _isEditModeUseState.value = value;
  }

  final ValueNotifier<WinResultUiModel> _winResultUseState =
      useState(WinResultUiModel.empty());

  WinResultUiModel get winResultUiModel => _winResultUseState.value;

  void onBuild() {
    useEffectOnce(() {
      _canProcessUseState.value = true;
      return () async {
        _canProcessUseState.value = false;
        await _textRecognizer.close();
      };
    });

    useValueChanged<InputImage?, Future<InputImage?>>(
      _inputImageUseState.value,
      (oldValue, oldResult) async {
        final inputImage = _inputImageUseState.value;
        if (inputImage == null) {
          return;
        }
        await _onRecognizeProcess(inputImage);
      },
    );
  }

  Future _onRecognizeProcess(InputImage inputImage) async {
    if (_isEditModeUseState.value) return;
    if (!_canProcessUseState.value) return;
    if (_isBusyUseState.value) return;

    _isBusyUseState.value = true;
    final recognisedText = await _textRecognizer.processImage(inputImage);
    final recognizedText = recognisedText.toRecognizedText();
    _paintRecognizedResultIfNeed(
      inputImage,
      recognizedText,
    );
    await _onJudgeNumberFrom(recognizedText);
    _isBusyUseState.value = false;
  }

  void _paintRecognizedResultIfNeed(
    InputImage inputImage,
    model.RecognizedText recognizedText,
  ) {
    final size = inputImage.inputImageData?.size;
    final rotation = inputImage.inputImageData?.imageRotation;
    if (size != null && rotation != null) {
      final painter = NumberDetectorPainter(recognizedText, size, rotation);
      _customPaintUseState.value = CustomPaint(painter: painter);
    } else {
      _customPaintUseState.value = null;
    }
  }

  Future _onJudgeNumberFrom(model.RecognizedText recognizedText) async {
    final winType = await _judgeNumbersUseCase.execute(recognizedText);
    _winResultUseState.value = WinResultUiModel.from(winType);
  }
}
