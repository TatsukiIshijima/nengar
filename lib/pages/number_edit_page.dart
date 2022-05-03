import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/extension/RegExpExtension.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/usecase/load_numbers_usecase.dart';
import 'package:nengar/usecase/save_numbers_usecase.dart';
import 'package:nengar/widgets/number_input_field.dart';

class NumberEditPage extends HookWidget {
  const NumberEditPage(
    this._appRouter,
    this._numbersRepository, {
    Key? key,
  }) : super(key: key);

  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;

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

    final loadUseCaseRef = useRef(LoadNumbersUseCase(_numbersRepository));
    final saveUseCaseRef =
        useRef(SaveNumbersUseCase(context, _appRouter, _numbersRepository));

    useEffectOnce(() {
      loadUseCaseRef.value.execute().then((numbersData) {
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

    final firstValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isSixDigitsNumber(),
      controller: firstTextEditingController,
      initialValue: false,
    );
    final secondValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isFourDigitsNumber(),
      controller: secondTextEditingController,
      initialValue: false,
    );
    final thirdPrimaryValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isTwoDigitsNumber(),
      controller: thirdPrimaryTextEditingController,
      initialValue: false,
    );
    final thirdSecondaryValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isTwoDigitsNumber(),
      controller: thirdSecondaryTextEditingController,
      initialValue: false,
    );
    final thirdTertiaryValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isTwoDigitsNumber(),
      controller: thirdTertiaryTextEditingController,
      initialValue: false,
    );

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
                      child: PlatformElevatedButton(
                        onPressed: firstValidate &&
                                secondValidate &&
                                thirdPrimaryValidate &&
                                thirdSecondaryValidate &&
                                thirdTertiaryValidate
                            ? () async {
                                await saveUseCaseRef.value.execute(
                                  firstTextEditingController.text,
                                  secondTextEditingController.text,
                                  thirdPrimaryTextEditingController.text,
                                  thirdSecondaryTextEditingController.text,
                                  thirdTertiaryTextEditingController.text,
                                );
                              }
                            : null,
                        child: PlatformText(
                          '保存',
                          style: subTitle2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        material: (_, __) => MaterialElevatedButtonData(
                          style: ElevatedButton.styleFrom(
                            // primary: saveBtnBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        cupertino: (_, __) => CupertinoElevatedButtonData(
                          borderRadius: BorderRadius.circular(24),
                          // color: saveBtnBackgroundColor,
                        ),
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
