import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/authentication/data/datasource/authentication_remote_datasource.dart';
import 'package:bloc_tdd/src/core/utils/typedef.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDatasource);

  final AuthenticationRemoteDatasource _remoteDatasource;

  @override
  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
