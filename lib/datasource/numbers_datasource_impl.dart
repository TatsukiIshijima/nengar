import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nengar/datasource/numbers_datasouce.dart';
import 'package:nengar/model/numbers_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumbersDataSourceImpl extends NumbersDataSource {
  @override
  Future<NumbersData?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final numbersDataStr = prefs.getString(numbersDataSourceKey);
    if (numbersDataStr == null) {
      return null;
    }
    if (numbersDataStr.isEmpty) {
      return null;
    }
    final numbersDataMap = jsonDecode(numbersDataStr);
    final numbersData = NumbersData.fromJson(numbersDataMap);
    return numbersData;
  }

  @override
  Future<void> save(NumbersData numbersData) async {
    final prefs = await SharedPreferences.getInstance();
    final numbersDataString = jsonEncode(numbersData.toJson());
    prefs.setString(numbersDataSourceKey, numbersDataString);
  }

  @visibleForTesting
  static const numbersDataSourceKey = 'numbersDataSource';
}
