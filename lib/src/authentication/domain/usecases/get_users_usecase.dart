import 'package:bloc_tdd/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/authentication_repository.dart';

class GetUsersUsecase extends UsecaseWithoutParams<List<User>> {
  const GetUsersUsecase(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async {
    return _repository.getUsers();
  }
}
