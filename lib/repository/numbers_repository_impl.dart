import 'package:nengar/datasource/numbers_datasouce.dart';
import 'package:nengar/model/numbers_data.dart';
import 'package:nengar/repository/numbers_repository.dart';

class NumbersRepositoryImpl extends NumbersRepository {
  NumbersRepositoryImpl(this.numbersDataSource);

  final NumbersDataSource numbersDataSource;

  NumbersData? _cache;

  @override
  Future<NumbersData?> load() async {
    if (_cache != null) {
      return _cache;
    }
    final localData = await numbersDataSource.load();
    _cache = localData;
    return localData;
  }

  @override
  Future<void> save(NumbersData numbersData) async {
    _cache = null;
    await numbersDataSource.save(numbersData);
  }
}
