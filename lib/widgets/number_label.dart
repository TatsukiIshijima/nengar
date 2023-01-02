import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nengar/text_style.dart';

class NumberLabel extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const NumberLabel({
    Key? key,
    required this.label,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformText(
      label,
      style: textStyle ?? title3,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: 1,
    );
  }
}
