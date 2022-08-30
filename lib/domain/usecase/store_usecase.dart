import '../../data/network/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';



class StoreUseCase implements BaseUseCase<void, StoreDetails> {
  final Repository _repository;

  StoreUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(
      void input) async {
    return await _repository.getStoreData();
  }
}
