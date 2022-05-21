import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/extension/RegExpExtension.dart';

class RecognizedText {
  RecognizedText(this.text, this.blocks);

  final String text;
  final List<TextBlock> blocks;
}

extension RecognizedTextExtension on RecognizedText {
  RecognizedText filteredByNumber() {
    final filteredBlocks =
        blocks.where((block) => block.text.isSixDigitsNumber()).toList();
    return RecognizedText(text, filteredBlocks);
  }
}
