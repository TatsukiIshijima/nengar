import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nengar/text_style.dart';

class NumberText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const NumberText({
    Key? key,
    required this.text,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformText(
      text,
      style: textStyle ?? subTitle1,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: 1,
    );
  }
}
