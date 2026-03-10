import 'package:bloc_tdd/src/authentication/domain/entities/user_entity.dart';
import 'package:bloc_tdd/src/core/core.dart';

abstract interface class AuthenticationRepository {
  AuthenticationRepository();

  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  ResultFuture<List<User>> getUsers();
}
