import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/extension/RegExpExtension.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/usecase/load_numbers_usecase.dart';
import 'package:nengar/usecase/save_numbers_usecase.dart';
import 'package:nengar/widgets/number_edit_page_header.dart';
import 'package:nengar/widgets/number_input_section.dart';
import 'package:nengar/widgets/third_number_input_section.dart';

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
      loadUseCaseRef.value.execute().then((uiModel) {
        firstTextEditingController.text = uiModel.firstWinNumber;
        secondTextEditingController.text = uiModel.secondWinNumber;
        thirdPrimaryTextEditingController.text = uiModel.thirdPrimaryWinNumber;
        thirdSecondaryTextEditingController.text =
            uiModel.thirdSecondaryWinNumber;
        thirdTertiaryTextEditingController.text =
            uiModel.thirdTertiaryWinNumber;
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

    bool isSavable = firstValidate &&
        secondValidate &&
        thirdPrimaryValidate &&
        thirdSecondaryValidate &&
        thirdTertiaryValidate;

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(AppLocalizations.of(context)!.editPageTitle),
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                    child: NumberEditPageHeader(
                      title: AppLocalizations.of(context)!.editPageHeaderTitle,
                      subTitle:
                          AppLocalizations.of(context)!.editPageHeaderSubTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: NumberInputSection(
                      title: AppLocalizations.of(context)!
                          .editPageFirstNumberSectionTitle,
                      textEditingController: firstTextEditingController,
                      maxLength: 6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: NumberInputSection(
                      title: AppLocalizations.of(context)!
                          .editPageSecondNumberSectionTitle,
                      textEditingController: secondTextEditingController,
                      maxLength: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: ThirdNumberInputSection(
                      title: AppLocalizations.of(context)!
                          .editPageThirdNumberSectionTitle,
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
                        onPressed: isSavable
                            ? () async {
                                await saveUseCaseRef.value.execute(
                                  WinNumbersUiModel(
                                    firstTextEditingController.text,
                                    secondTextEditingController.text,
                                    thirdPrimaryTextEditingController.text,
                                    thirdSecondaryTextEditingController.text,
                                    thirdTertiaryTextEditingController.text,
                                  ),
                                );
                              }
                            : null,
                        child: PlatformText(
                          AppLocalizations.of(context)!.editPageSaveButtonLabel,
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