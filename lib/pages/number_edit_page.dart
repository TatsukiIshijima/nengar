import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/usecase/load_numbers_usecase.dart';
import 'package:nengar/usecase/save_numbers_usecase.dart';
import 'package:nengar/widgets/number_input_field.dart';

class NumberEditPage extends HookWidget {
  NumberEditPage({
    Key? key,
    required this.appRouter,
    required this.numbersRepository,
  }) : super(key: key);

  final AppRouter appRouter;
  final NumbersRepository numbersRepository;

  late final LoadNumbersUseCase _loadNumbersUseCase;
  late final SaveNumbersUseCase _saveNumbersUseCase;

  @override
  Widget build(BuildContext context) {
    final firstTextEditingController = useTextEditingController(text: '');
    final secondTextEditingController = useTextEditingController(text: '');
    final thirdPrimaryTextEditingController =
        useTextEditingController(text: '');
    final thirdSecondaryTextEditingController =
        useTextEditingController(text: '');
    final thirdTertiaryTextEditingController =
        useTextEditingController(text: '');

    useEffectOnce(() {
      _loadNumbersUseCase = LoadNumbersUseCase(numbersRepository);
      _saveNumbersUseCase =
          SaveNumbersUseCase(context, appRouter, numbersRepository);

      _loadNumbersUseCase.execute().then((numbersData) {
        final winNumbers = numbersData?.winNumbers;
        final thirdWinNumbers = winNumbers?.thirdWinNumbers;
        firstTextEditingController.text = winNumbers?.firstWinNumber ?? '';
        secondTextEditingController.text = winNumbers?.secondWinNumber ?? '';
        thirdPrimaryTextEditingController.text =
            thirdWinNumbers?.primaryWinNumber ?? '';
        thirdSecondaryTextEditingController.text =
            thirdWinNumbers?.secondaryWinNumber ?? '';
        thirdTertiaryTextEditingController.text =
            thirdWinNumbers?.tertiaryWinNumber ?? '';
      });
    });

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(
          '編集画面',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                    child: NumberEditPageHeader(
                      title: '今年の当選番号を入力しましょう',
                      subTitle: '１〜３等の当選番号を入力して\n「保存」を押してください。',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: NumberInputSection(
                      title: '１等（６けた）',
                      textEditingController: firstTextEditingController,
                      maxLength: 6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: NumberInputSection(
                      title: '２等（下４けた）',
                      textEditingController: secondTextEditingController,
                      maxLength: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: ThirdNumberInputSection(
                      title: '３等（下２けた）',
                      primaryTextEditingController:
                          thirdPrimaryTextEditingController,
                      secondaryTextEditingController:
                          thirdSecondaryTextEditingController,
                      tertiaryTextEditingController:
                          thirdTertiaryTextEditingController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      child: CupertinoButton.filled(
                        child: PlatformText(
                          '保存',
                          style: subTitle2,
                        ),
                        onPressed: () {
                          appRouter.goRecognizePage(context);
                        },
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            child: PlatformText(
              title,
              textAlign: TextAlign.center,
              style: subTitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: PlatformText(
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
            child: PlatformText(
              title,
              style: subTitle1,
            ),
          ),
          NumberInputField(
            textEditingController: textEditingController,
            maxLength: maxLength,
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
            child: PlatformText(
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: NumberInputField(
              textEditingController: tertiaryTextEditingController,
              maxLength: 2,
            ),
          ),
        ],
      ),
    );
  }
}
