import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nengar/datasource/numbers_datasource_impl.dart';
import 'package:nengar/model/numbers_data.dart';
import 'package:nengar/model/third_win_numbers.dart';
import 'package:nengar/model/win_numbers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NumbersDataSource_load', () {
    final thirdWinNumbers = ThirdWinNumbers('123456', '789012', '345678');
    final winNumbers = WinNumbers('135791', '24682', thirdWinNumbers);
    final numbersData = NumbersData(winNumbers, DateTime.utc(2022, 1, 1));

    late String numbersDataStr;

    setUp(() {
      numbersDataStr = jsonEncode(numbersData.toJson());
    });

    test('load_returnNumbersIfSaved', () async {
      SharedPreferences.setMockInitialValues(
          {NumbersDataSourceImpl.numbersDataSourceKey: numbersDataStr});

      final numbersDataSource = NumbersDataSourceImpl();
      final data = await numbersDataSource.load();

      expect(data?.savedDateTime, DateTime.utc(2022, 1, 1));
      expect(data?.winNumbers.firstWinNumber, winNumbers.firstWinNumber);
      expect(data?.winNumbers.secondWinNumber, winNumbers.secondWinNumber);
      expect(data?.winNumbers.thirdWinNumbers.primaryWinNumber,
          thirdWinNumbers.primaryWinNumber);
      expect(data?.winNumbers.thirdWinNumbers.secondaryWinNumber,
          thirdWinNumbers.secondaryWinNumber);
      expect(data?.winNumbers.thirdWinNumbers.tertiaryWinNumber,
          thirdWinNumbers.tertiaryWinNumber);
    });

    test('load_returnNullIfNotExistKey', () async {
      SharedPreferences.setMockInitialValues({});

      final numbersDataSource = NumbersDataSourceImpl();
      final data = await numbersDataSource.load();

      expect(data, null);
    });

    test('load_returnNullIfNotExistData', () async {
      SharedPreferences.setMockInitialValues(
          {NumbersDataSourceImpl.numbersDataSourceKey: ''});

      final numbersDataSource = NumbersDataSourceImpl();
      final data = await numbersDataSource.load();

      expect(data, null);
    });
  });
}
