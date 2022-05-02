import 'package:nengar/model/numbers_data.dart';

abstract class NumbersRepository {
  Future<void> save(NumbersData numbersData);

  Future<NumbersData?> load();
}
