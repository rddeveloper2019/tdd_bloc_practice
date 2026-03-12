import 'package:bloc_tdd/src/authentication/data/data.dart';
import 'package:bloc_tdd/src/authentication/data/datasource/authentication_remote_datasource.dart';

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl();

  //TDD
  @override
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {}

  @override
  Future<List<UserModel>> getUsers() async {
    return [];
  }
}
