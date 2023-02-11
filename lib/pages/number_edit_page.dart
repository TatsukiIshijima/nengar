import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:nengar/extension/RegExpExtension.dart';
import 'package:nengar/gen/colors.gen.dart';
import 'package:nengar/gen/fonts.gen.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/viewmodel/number_edit_viewmodel.dart';
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

  void _showSuccessDialog(BuildContext context) {
    showPlatformDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PlatformAlertDialog(
        title: PlatformText(
            AppLocalizations.of(context)!.editPageSaveSuccessDialogTitle),
        content: PlatformText(
            AppLocalizations.of(context)!.editPageSaveSuccessDialogContent),
        actions: [
          PlatformDialogAction(
            child:
                PlatformText(AppLocalizations.of(context)!.positiveButtonLabel),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              _appRouter.goRecognizePage(
                context,
                forceUpdate: true,
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberEditViewModelRef =
        useRef(NumberEditViewModel(_numbersRepository));
    final numberEditViewModel = numberEditViewModelRef.value;

    final firstValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isSixDigitsNumber(),
      controller: numberEditViewModel.firstTextEditingController,
      initialValue: false,
    );
    final secondValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isFourDigitsNumber(),
      controller: numberEditViewModel.secondTextEditingController,
      initialValue: false,
    );
    final thirdPrimaryValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isTwoDigitsNumber(),
      controller: numberEditViewModel.thirdPrimaryTextEditingController,
      initialValue: false,
    );
    final thirdSecondaryValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isTwoDigitsNumber(),
      controller: numberEditViewModel.thirdSecondaryTextEditingController,
      initialValue: false,
    );
    final thirdTertiaryValidate = useTextFormValidator(
      validator: (value) => value.isNotEmpty && value.isTwoDigitsNumber(),
      controller: numberEditViewModel.thirdTertiaryTextEditingController,
      initialValue: false,
    );

    bool isSavable = firstValidate &&
        secondValidate &&
        thirdPrimaryValidate &&
        thirdSecondaryValidate &&
        thirdTertiaryValidate;

    numberEditViewModel.onBuild();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(AppLocalizations.of(context)!.editPageTitle),
      ),
      body: SafeArea(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 32),
                  child: NumberEditPageHeader(
                    title: AppLocalizations.of(context)!.editPageHeaderTitle,
                    subTitle:
                        AppLocalizations.of(context)!.editPageHeaderSubTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                  child: NumberInputSection(
                    title: AppLocalizations.of(context)!
                        .editPageFirstNumberSectionTitle,
                    textEditingController:
                        numberEditViewModel.firstTextEditingController,
                    maxLength: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: NumberInputSection(
                    title: AppLocalizations.of(context)!
                        .editPageSecondNumberSectionTitle,
                    textEditingController:
                        numberEditViewModel.secondTextEditingController,
                    maxLength: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: ThirdNumberInputSection(
                    title: AppLocalizations.of(context)!
                        .editPageThirdNumberSectionTitle,
                    primaryTextEditingController:
                        numberEditViewModel.thirdPrimaryTextEditingController,
                    secondaryTextEditingController:
                        numberEditViewModel.thirdSecondaryTextEditingController,
                    tertiaryTextEditingController:
                        numberEditViewModel.thirdTertiaryTextEditingController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: PlatformElevatedButton(
                      onPressed: isSavable
                          ? () async {
                              await numberEditViewModel.saveNumbers(
                                  () => _showSuccessDialog(context));
                            }
                          : null,
                      material: (_, __) => MaterialElevatedButtonData(
                        style: ElevatedButton.styleFrom(
                          // primary: saveBtnBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      // FIXME:WORKAROUND対応：ここだけThemeが何故か効かないので色とフォントを直指定
                      cupertino: (_, __) => CupertinoElevatedButtonData(
                        originalStyle: true,
                        borderRadius: BorderRadius.circular(24),
                        color: ColorName.primaryColor,
                      ),
                      child: PlatformText(
                        AppLocalizations.of(context)!.editPageSaveButtonLabel,
                        style: subTitle2.copyWith(
                          color: Colors.white,
                          fontFamily: FontFamily.notoSerifJP,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
