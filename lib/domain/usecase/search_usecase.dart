import '../../data/network/failure.dart';

import '../models/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';


class SearchUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  SearchUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.search(input);
  }
}