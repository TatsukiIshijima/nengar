import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nengar/text_style.dart';

class NumberInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final int maxLines;
  final int maxLength;
  final Function? onEditingComplete;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const NumberInputField({
    Key? key,
    required this.textEditingController,
    this.focusNode,
    this.maxLines = 1,
    this.maxLength = 6,
    this.onEditingComplete,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformTextField(
      material: (_, __) => MaterialTextFieldData(),
      cupertino: (_, __) => CupertinoTextFieldData(),
      controller: textEditingController,
      focusNode: focusNode,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black),
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(4),
      //   ),
      // ),
      keyboardType: TextInputType.number,
      maxLines: maxLines,
      maxLength: maxLength,
      onEditingComplete: onEditingComplete?.call(),
      onChanged: (text) => onChanged?.call(text),
      onSubmitted: (text) => onSubmitted?.call(text),
      style: bodyText1,
    );
  }
}