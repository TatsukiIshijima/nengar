import 'package:flutter/material.dart';
import 'package:nengar/gen/assets.gen.dart';
import 'package:nengar/widgets/number_input_field.dart';
import 'package:nengar/widgets/number_label.dart';

class ThirdNumberInputSection extends StatelessWidget {
  final String title;
  final TextEditingController primaryTextEditingController;
  final TextEditingController secondaryTextEditingController;
  final TextEditingController tertiaryTextEditingController;

  const ThirdNumberInputSection({
    Key? key,
    required this.title,
    required this.primaryTextEditingController,
    required this.secondaryTextEditingController,
    required this.tertiaryTextEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: Assets.image.targetImg.provider(),
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 4),
                NumberLabel(label: title),
              ],
            ),
          ),
          NumberInputField(
            textEditingController: primaryTextEditingController,
            textInputAction: TextInputAction.next,
            maxLength: 2,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: NumberInputField(
              textEditingController: secondaryTextEditingController,
              textInputAction: TextInputAction.next,
              maxLength: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: NumberInputField(
              textEditingController: tertiaryTextEditingController,
              textInputAction: TextInputAction.done,
              maxLength: 2,
            ),
          ),
        ],
      ),
    );
  }
}
