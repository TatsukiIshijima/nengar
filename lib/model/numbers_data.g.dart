// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numbers_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumbersData _$NumbersDataFromJson(Map<String, dynamic> json) => NumbersData(
      WinNumbers.fromJson(json['winningNumbers'] as Map<String, dynamic>),
      DateTime.parse(json['savedDateTime'] as String),
    );

Map<String, dynamic> _$NumbersDataToJson(NumbersData instance) =>
    <String, dynamic>{
      'winningNumbers': instance.winNumbers,
      'savedDateTime': instance.savedDateTime.toIso8601String(),
    };