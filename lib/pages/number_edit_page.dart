import 'package:flutter/cupertino.dart';
import 'package:nengar/text_style.dart';
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
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                child: NumberEditPageHeader(
                  title: '今年の当選番号を入力しましょう',
                  subTitle: '１〜３等の当選番号を入力して\n「保存」を押してください。',
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: NumberInputSection(
                  title: '１等（６けた）',
                  textEditingController: _firstTextEditingController,
                  maxLength: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: NumberInputSection(
                  title: '２等（下４けた）',
                  textEditingController: _secondTextEditingController,
                  maxLength: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: CupertinoButton.filled(
                        child: const Text(
                          '保存',
                          style: subTitle2,
                        ),
                        onPressed: () {},
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberEditPageHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const NumberEditPageHeader({
    Key? key,
    required this.title,
    required this.subTitle,
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
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: subTitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: subTitle2,
            ),
          ),
        ],
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
            child: Text(
              title,
              style: subTitle1,
            ),
          ),
          NumberInputField(
            textEditingController: textEditingController,
          ),
        ],
      ),
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
            child: Text(
              title,
              style: subTitle1,
            ),
          ),
          NumberInputField(
            textEditingController: primaryTextEditingController,
            maxLength: 2,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: NumberInputField(
              textEditingController: secondaryTextEditingController,
              maxLength: 2,
            ),
          ),
        ],
      ),
    );
  }
}
