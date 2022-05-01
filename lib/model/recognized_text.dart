import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/extension/RegExpExtension.dart';

class RecognizedText {
  RecognizedText(this.text, this.blocks);

  final String text;
  final List<TextBlock> blocks;
}

extension RecognizedTextExtension on RecognizedText {
  RecognizedText filteredByNumber() {
    final filteredBlocks =
        blocks.where((block) => block.text.isNumber()).toList();
    return RecognizedText(text, filteredBlocks);
  }
}