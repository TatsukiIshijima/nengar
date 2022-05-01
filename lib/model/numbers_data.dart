import 'package:json_annotation/json_annotation.dart';
import 'package:nengar/model/win_numbers.dart';

part 'numbers_data.g.dart';

@JsonSerializable()
class NumbersData {
  NumbersData(
    this.winNumbers,
    this.savedDateTime,
  );

  final WinNumbers winNumbers;
  final DateTime savedDateTime;

  factory NumbersData.fromJson(Map<String, dynamic> json) =>
      _$NumbersDataFromJson(json);

  Map<String, dynamic> toJson() => _$NumbersDataToJson(this);
}
