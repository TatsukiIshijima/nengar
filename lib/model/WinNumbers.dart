import 'package:json_annotation/json_annotation.dart';
import 'package:nengar/model/ThirdWinNumbers.dart';

part 'WinNumbers.g.dart';

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
}
