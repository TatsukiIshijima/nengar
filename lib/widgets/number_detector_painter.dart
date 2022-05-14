import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nengar/model/recognized_text.dart' as model;
import 'package:nengar/widgets/coordinates_translator.dart';

/// https://github.com/bharat-biradar/Google-Ml-Kit-plugin/blob/master/packages/google_ml_kit/example/lib/vision_detector_views/painters/text_detector_painter.dart

class NumberDetectorPainter extends CustomPainter {
  NumberDetectorPainter(
      this.recognizedText, this.absoluteImageSize, this.rotation);

  final model.RecognizedText recognizedText;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final background = Paint()..color = Color(0x99000000);

    for (final textBlock in recognizedText.blocks) {
      final builder = ParagraphBuilder(
        ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 16,
          textDirection: TextDirection.ltr,
        ),
      );
      builder.pushStyle(
        ui.TextStyle(
          color: Colors.lightGreenAccent,
          background: background,
        ),
      );
      builder.addText(textBlock.text);
      builder.pop();

      final left = translateX(
          textBlock.boundingBox.left, rotation, size, absoluteImageSize);
      final top = translateY(
          textBlock.boundingBox.top, rotation, size, absoluteImageSize);
      final right = translateX(
          textBlock.boundingBox.right, rotation, size, absoluteImageSize);
      final bottom = translateY(
          textBlock.boundingBox.bottom, rotation, size, absoluteImageSize);

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      canvas.drawParagraph(
        builder.build()
          ..layout(
            ParagraphConstraints(
              width: right - left,
            ),
          ),
        Offset(left, top),
      );
    }
  }

  @override
  bool shouldRepaint(NumberDetectorPainter oldDelegate) {
    return oldDelegate.recognizedText != recognizedText;
  }
}
