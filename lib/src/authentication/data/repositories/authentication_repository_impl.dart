import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/errors/errors.dart';
import 'package:bloc_tdd/src/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDatasource);

  final AuthenticationRemoteDatasource _remoteDatasource;

  //TDD
  //CALL remoteDatasource
  //check remoteDatasource returns proper data
  //check remoteDatasource returns proper data or failure
  //check remoteDatasource doesn't throw an exception but failure or proper data

  @override
  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      await _remoteDatasource.createUser(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromApiException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDatasource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromApiException(e));
    }
  }
}
