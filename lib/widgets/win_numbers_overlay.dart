import 'package:flutter/widgets.dart';
import 'package:nengar/text_style.dart';
import 'package:nengar/widgets/number_label.dart';
import 'package:nengar/widgets/number_text.dart';

class WinNumbersOverlay extends StatelessWidget {
  final String firstWinNumber;
  final String secondWinNumber;
  final String thirdPrimaryWinNumber;
  final String thirdSecondaryWinNumber;
  final String thirdTertiaryWinNumber;

  const WinNumbersOverlay({
    Key? key,
    required this.firstWinNumber,
    required this.secondWinNumber,
    required this.thirdPrimaryWinNumber,
    required this.thirdSecondaryWinNumber,
    required this.thirdTertiaryWinNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WinNumberRow(
          winNumberLabel: "１等",
          winNumberText: firstWinNumber,
        ),
        _WinNumberRow(
          winNumberLabel: "２等",
          winNumberText: secondWinNumber,
        ),
        _WinNumberRow(
          winNumberLabel: "３等",
          winNumberText:
              "$thirdPrimaryWinNumber, $thirdSecondaryWinNumber, $thirdTertiaryWinNumber",
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberLabel(
          label: winNumberLabel,
          textStyle: subTitle2,
        ),
        const SizedBox(
          width: 8,
        ),
        NumberText(
          text: winNumberText,
          textStyle: subTitle2,
        ),
      ],
    );
  }
}