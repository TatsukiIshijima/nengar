import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/extension/RegExpExtension.dart';
import 'package:nengar/model/recognized_text.dart' as model;

extension RecognisedTextExtension on RecognizedText {
  model.RecognizedText toRecognizedText() {
    final filteredBlocks =
        blocks.where((block) => block.text.isSixDigitsNumber()).toList();
    return model.RecognizedText(text, filteredBlocks);
  }
}
