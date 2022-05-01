// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WinNumbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WinNumbers _$WinNumbersFromJson(Map<String, dynamic> json) => WinNumbers(
      json['firstWinNumber'] as String? ?? '',
      json['secondWinNumber'] as String? ?? '',
      ThirdWinNumbers.fromJson(json['thirdWinNumbers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WinNumbersToJson(WinNumbers instance) =>
    <String, dynamic>{
      'firstWinNumber': instance.firstWinNumber,
      'secondWinNumber': instance.secondWinNumber,
      'thirdWinNumbers': instance.thirdWinNumbers,
    };
