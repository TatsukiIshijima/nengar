import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/model/recognized_text.dart' as model;

extension RecognisedTextExtension on RecognizedText {
  model.RecognizedText toRecognizedText() {
    return model.RecognizedText(text, blocks);
  }
}
