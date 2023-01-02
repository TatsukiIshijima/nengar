import 'package:nengar/model/numbers_data.dart';

abstract class NumbersDataSource {
  Future<void> save(NumbersData numbersData);

  Future<NumbersData?> load();
}
