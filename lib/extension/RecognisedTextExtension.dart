import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/model/recognized_text.dart' as model;

extension RecognisedTextExtension on RecognizedText {
  model.RecognizedText toRecognizedText() {
    return model.RecognizedText(text, blocks);
  }
}
