import 'package:bloc_tdd/src/authentication/data/data.dart';

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl();

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
