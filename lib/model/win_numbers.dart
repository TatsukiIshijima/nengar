import 'package:json_annotation/json_annotation.dart';
import 'package:nengar/model/third_win_numbers.dart';
import 'package:nengar/model/uimodel/win_numbers_uimodel.dart';

part 'win_numbers.g.dart';

@JsonSerializable()
class WinNumbers {
  WinNumbers(
    this.firstWinNumber,
    this.secondWinNumber,
    this.thirdWinNumbers,
  );

  @JsonKey(defaultValue: '')
  final String firstWinNumber;
  @JsonKey(defaultValue: '')
  final String secondWinNumber;
  final ThirdWinNumbers thirdWinNumbers;

  factory WinNumbers.fromJson(Map<String, dynamic> json) =>
      _$WinNumbersFromJson(json);

  Map<String, dynamic> toJson() => _$WinNumbersToJson(this);

  factory WinNumbers.from(WinNumbersUiModel uiModel) {
    return WinNumbers(
      uiModel.firstWinNumber,
      uiModel.secondWinNumber,
      ThirdWinNumbers(
        uiModel.thirdPrimaryWinNumber,
        uiModel.thirdSecondaryWinNumber,
        uiModel.thirdTertiaryWinNumber,
      ),
    );
  }
}
