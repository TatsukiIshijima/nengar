import 'package:flutter/cupertino.dart';
import 'package:nengar/widgets/number_input_field.dart';

class NumberEditPage extends StatelessWidget {
  final _firstTextEditingController = TextEditingController();
  final _secondTextEditingController = TextEditingController();
  final _thirdPrimaryTextEditingController = TextEditingController();
  final _thirdSecondaryTextEditingController = TextEditingController();
  final _thirdTertiaryTextEditingController = TextEditingController();

  NumberEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 48,
                  ),
                  child: const Text('今年の当選番号を入力しましょう'),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: NumberInputSection(
                    title: '１等（６けた）',
                    textEditingController: _firstTextEditingController,
                    maxLength: 6,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: NumberInputSection(
                    title: '２等（下４けた）',
                    textEditingController: _secondTextEditingController,
                    maxLength: 4,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: ThirdNumberInputSection(
                    title: '３等（下２けた）',
                    primaryTextEditingController:
                        _thirdPrimaryTextEditingController,
                    secondaryTextEditingController:
                        _thirdSecondaryTextEditingController,
                    tertiaryTextEditingController:
                        _thirdTertiaryTextEditingController,
                  ),
                ),
                CupertinoButton(
                  child: const Text('保存'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(
          text: title,
        ),
        const SizedBox(
          height: 8,
        ),
        NumberInputField(
          textEditingController,
          maxLength: maxLength,
        ),
      ],
    );
  }
}

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(
          text: title,
        ),
        const SizedBox(
          height: 8,
        ),
        NumberInputField(
          primaryTextEditingController,
          maxLength: 2,
        ),
        const SizedBox(
          height: 12,
        ),
        NumberInputField(
          secondaryTextEditingController,
          maxLength: 2,
        ),
        const SizedBox(
          height: 12,
        ),
        NumberInputField(
          tertiaryTextEditingController,
          maxLength: 2,
        ),
      ],
    );
  }
}

class Label extends StatelessWidget {
  final String text;

  const Label({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
