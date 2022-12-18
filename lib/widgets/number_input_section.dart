import 'package:flutter/widgets.dart';
import 'package:nengar/widgets/number_input_field.dart';
import 'package:nengar/widgets/number_label.dart';

class NumberInputSection extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final int maxLength;

  const NumberInputSection({
    Key? key,
    required this.title,
    required this.textEditingController,
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
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
              child: NumberLabel(
                label: title,
              )),
          NumberInputField(
            textEditingController: textEditingController,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
