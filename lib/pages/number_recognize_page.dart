import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nengar/model/uimodel/win_result_uimodel.dart';
import 'package:nengar/repository/numbers_repository.dart';
import 'package:nengar/router/app_router.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/viewmodel/number_load_viewmodel.dart';
import 'package:nengar/viewmodel/number_recognize_viewmodel.dart';
import 'package:nengar/widgets/background.dart';
import 'package:nengar/widgets/camera_view.dart';
import 'package:nengar/widgets/win_numbers_overlay.dart';

class NumberRecognizePage extends HookWidget {
  const NumberRecognizePage(
    this._appRouter,
    this._numbersRepository,
    this._forceUpdate, {
    Key? key,
  }) : super(key: key);

  final AppRouter _appRouter;
  final NumbersRepository _numbersRepository;
  final bool _forceUpdate;

  @override
  Widget build(BuildContext context) {
    // インスタンスがbuild毎に作られないようにuseRefを使用する
    final numberLoadViewModelRef =
        useRef(NumberLoadViewModel(_numbersRepository));
    final numberRecognizeViewModelRef =
        useRef(NumberRecognizeViewModel(_numbersRepository));

    numberLoadViewModelRef.value.onBuild(_forceUpdate);
    numberRecognizeViewModelRef.value.onBuild();

    useEffect(
      () {
        // FIXME:以下エラー発生
        // Cannot listen to inherited widgets inside HookState.initState. Use HookState.build instead
        // recognizeCameraViewModelRef.value.isEditMode = _appRouter
        //     .location(useContext())
        //     .contains(AppRouter.numberEditPageRoutePath);
        // return () {};
      },
      [_appRouter.location(context)],
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(AppLocalizations.of(context)!.appName),
        trailingActions: [
          IconButton(
            onPressed: () {
              // FIXME:go_routerのサブルート遷移だと認識画面のカメラが止まらないので対応必要
              _appRouter.goEditPage(context);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: _RecognizePageBody(
          numberLoadViewModelRef.value,
          numberRecognizeViewModelRef.value,
        ),
      ),
    );
  }
}

class _RecognizePageBody extends StatelessWidget {
  const _RecognizePageBody(
    this._numberLoadViewModel,
    this._numberRecognizeViewModel, {
    Key? key,
  }) : super(key: key);

  final NumberLoadViewModel _numberLoadViewModel;
  final NumberRecognizeViewModel _numberRecognizeViewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _RecognizeCameraView(
          customPaint: _numberRecognizeViewModel.customPaint,
          onUpdateFrame: (image) {
            _numberRecognizeViewModel.inputImage = image;
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.black.withAlpha(64),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WinNumbersOverlay(
                        uiModel: _numberLoadViewModel.winNumbersUiModel,
                      ),
                      PlatformText(
                        AppLocalizations.of(context)!
                            .recognizePageCameraOperationHint,
                        textAlign: TextAlign.center,
                        style: subTitle1.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: _RecognizedWinResultSection(
                    uiModel: _numberRecognizeViewModel.winResultUiModel,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RecognizeCameraView extends StatelessWidget {
  const _RecognizeCameraView({
    required this.customPaint,
    required this.onUpdateFrame,
    Key? key,
  }) : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage) onUpdateFrame;

  @override
  Widget build(BuildContext context) {
    return CameraView(
      customPaint: customPaint,
      onImage: ((image) => onUpdateFrame(image)),
    );
  }
}

class _RecognizedWinResultSection extends StatelessWidget {
  final WinResultUiModel uiModel;

  const _RecognizedWinResultSection({
    Key? key,
    required this.uiModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: uiModel.resultImage != null
            ? Image(
                image: uiModel.resultImage!,
                fit: BoxFit.fitHeight,
              )
            : Container(),
      ),
    );
  }
}
