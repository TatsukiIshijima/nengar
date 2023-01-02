import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/widgets/number_label.dart';
import 'package:nengar/widgets/number_text.dart';

class WinNumbersOverlay extends StatelessWidget {
  final WinNumbersUiModel uiModel;

  const WinNumbersOverlay({
    Key? key,
    required this.uiModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _WinNumberRow(
          winNumberLabel: "１等",
          winNumberText: uiModel.firstWinNumber,
        ),
        _WinNumberRow(
          winNumberLabel: "２等",
          winNumberText: uiModel.secondWinNumber,
        ),
        _WinNumberRow(
          winNumberLabel: "３等",
          winNumberText: "${uiModel.thirdPrimaryWinNumber}, "
              "${uiModel.thirdSecondaryWinNumber}, "
              "${uiModel.thirdTertiaryWinNumber}",
        )
      ],
    );
  }
}

class _WinNumberRow extends StatelessWidget {
  final String winNumberLabel;
  final String winNumberText;

  const _WinNumberRow({
    Key? key,
    required this.winNumberLabel,
    required this.winNumberText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberLabel(
          label: winNumberLabel,
          textStyle: subTitle1.copyWith(color: Colors.white),
        ),
        const SizedBox(
          width: 8,
        ),
        NumberText(
          text: winNumberText,
          textStyle: subTitle1.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
