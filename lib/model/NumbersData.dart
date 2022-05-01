import 'package:json_annotation/json_annotation.dart';
import 'package:nengar/model/WinNumbers.dart';

part 'NumbersData.g.dart';

@JsonSerializable()
class NumbersData {
  NumbersData(
    this.winningNumbers,
    this.savedDateTime,
  );

  final WinNumbers winningNumbers;
  final DateTime savedDateTime;

  factory NumbersData.fromJson(Map<String, dynamic> json) =>
      _$NumbersDataFromJson(json);

  Map<String, dynamic> toJson() => _$NumbersDataToJson(this);
}
