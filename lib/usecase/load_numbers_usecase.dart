import 'package:nengar/model/numbers_data.dart';
import 'package:nengar/repository/numbers_repository.dart';

class LoadNumbersUseCase {
  LoadNumbersUseCase(this._numbersRepository);

  final NumbersRepository _numbersRepository;

  Future<NumbersData?> execute() async {
    return await _numbersRepository.load();
  }
}
