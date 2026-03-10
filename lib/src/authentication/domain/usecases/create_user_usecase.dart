import 'package:bloc_tdd/src/core/core.dart';
import 'package:equatable/equatable.dart';

import '../repositories/authentication_repository.dart';

class CreateUserUsecase extends UsecaseWithParams<void, CreateUserParams> {
  CreateUserUsecase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async {
    return _repository.createUser(
      name: params.name,
      avatar: params.avatar,
      createdAt: params.createdAt,
    );
  }
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  factory CreateUserParams.empty() {
    return CreateUserParams(
      createdAt: "_empty.createdAt",
      name: "_empty.name",
      avatar: "_empty.avatar",
    );
  }
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [createdAt, name, avatar];
}
