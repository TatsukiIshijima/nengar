import 'package:flutter/cupertino.dart';
import 'package:nengar/gen/assets.gen.dart';
import 'package:nengar/widgets/number_input_field.dart';
import 'package:nengar/widgets/number_label.dart';

class NumberInputSection extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final int maxLength;

  const NumberInputSection({
    Key? key,
    required this.title,
    required this.textEditingController,
    required this.textInputAction,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
            textEditingController: textEditingController,
            textInputAction: textInputAction,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
