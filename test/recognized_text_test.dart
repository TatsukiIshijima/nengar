import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/extension/RecognisedTextExtension.dart';

void main() {
  group('RecognizedText', () {
    final textBlock1 = TextBlock(
      text: '1234',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 10, 10),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );
    final textBlock2 = TextBlock(
      text: '12',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 10, 10),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );
    final textBlock3 = TextBlock(
      text: 'A123456',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 10, 10),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );
    final textBlock4 = TextBlock(
      text: 'a123456',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 10, 10),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );
    final textBlock5 = TextBlock(
      text: '123456A',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 10, 10),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );
    final textBlock6 = TextBlock(
      text: 'a123456',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 10, 10),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );
    final textBlock7 = TextBlock(
      text: '123456',
      lines: [],
      boundingBox: const Rect.fromLTRB(0, 0, 0, 0),
      recognizedLanguages: ['ja'],
      cornerPoints: [const Point(0, 0)],
    );

    final recognizedText = RecognizedText(
      text: '',
      blocks: [
        textBlock1,
        textBlock2,
        textBlock3,
        textBlock4,
        textBlock5,
        textBlock6,
        textBlock7,
      ],
    );

    test('toRecognizedText', () {
      final result = recognizedText.toRecognizedText();
      expect(result.blocks.length == 1, true);
      expect(result.blocks.first.text == '123456', true);
    });
  });
}
