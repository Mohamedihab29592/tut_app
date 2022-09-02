import 'package:dartz/dartz.dart';
import 'package:tut_app/data/mappers/mappers.dart';

import '../../data/data_source/data_source.dart';
import '../../data/data_source/local_data_source.dart';
import '../../data/network/error_handler.dart';
import '../../data/network/failure.dart';
import '../../data/network/network_info.dart';
import '../../data/network/requests.dart';
import '../../domain/repository/repository.dart';
import '../models/models.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API

      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      // get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid

      // its the time to get from API side
      if (await _networkInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getHomeData();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // return either right
            // return data
            // save home response to cache

            // save response in cache (local data source)
            _localDataSource.saveHomeToCache(response);

            return Right(response.toDomain());
          } else {
            // failure --return business error
            // return either left
            return Left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return internet connection error
        // return either left
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreData() async {
    try {
      // get response from cache
      final response = await _localDataSource.getStoreData();
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid

      // its the time to get from API side
      if (await _networkInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getStoreData();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // return either right
            // return data
            // save Store response to cache

            // save response in cache (local data source)
            _localDataSource.saveStoreToCache(response);

            return Right(response.toDomain());
          } else {
            // failure --return business error
            // return either left
            return Left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return internet connection error
        // return either left
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> search(
      String text) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await _remoteDataSource.getSearchData(text);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
}
}