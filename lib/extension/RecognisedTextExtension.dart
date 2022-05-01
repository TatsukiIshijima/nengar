import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/model/recognized_text.dart';

extension RecognisedTextExtension on RecognisedText {
  RecognizedText toRecognizedText() {
    return RecognizedText(text, blocks);
  }
}
