import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nengar/gen/colors.gen.dart';
import 'package:nengar/text_style.dart';

class NumberInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int maxLength;
  final Function? onEditingComplete;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const NumberInputField({
    Key? key,
    required this.textEditingController,
    this.focusNode,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength = 6,
    this.onEditingComplete,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformTextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      maxLines: maxLines,
      maxLength: maxLength,
      onEditingComplete: onEditingComplete?.call(),
      onChanged: (text) => onChanged?.call(text),
      onFieldSubmitted: (text) => onSubmitted?.call(text),
      style: title3,
      material: (context, platformTarget) => MaterialTextFormFieldData(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorName.colorLineColorDark,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorName.colorLineColorDark,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
        ),
      ),
      cupertino: (context, platformTarget) => CupertinoTextFormFieldData(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorName.colorLineColorDark,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
