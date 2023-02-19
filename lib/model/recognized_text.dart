import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizedText {
  RecognizedText(this.text, this.blocks);

  final String text;
  final List<TextBlock> blocks;
}
