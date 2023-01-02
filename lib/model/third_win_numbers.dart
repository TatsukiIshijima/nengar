import 'package:json_annotation/json_annotation.dart';

part 'third_win_numbers.g.dart';

@JsonSerializable()
class ThirdWinNumbers {
  ThirdWinNumbers(
    this.primaryWinNumber,
    this.secondaryWinNumber,
    this.tertiaryWinNumber,
  );

  @JsonKey(defaultValue: '')
  final String primaryWinNumber;
  @JsonKey(defaultValue: '')
  final String secondaryWinNumber;
  @JsonKey(defaultValue: '')
  final String tertiaryWinNumber;

  factory ThirdWinNumbers.fromJson(Map<String, dynamic> json) =>
      _$ThirdWinNumbersFromJson(json);

  Map<String, dynamic> toJson() => _$ThirdWinNumbersToJson(this);
}
