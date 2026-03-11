import 'package:bloc_tdd/src/authentication/data/data.dart';

abstract class AuthenticationRemoteDatasource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}
