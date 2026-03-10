import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

// what are class dependencies?
//* AuthenticationRepository

// how create a fake version of dependency?
//* Mocktail

// how we can control what our dependencies do?
//* Mocktail API

void main() {
  late CreateUserUsecase usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = CreateUserUsecase(repository);
  });

  final params = CreateUserParams.empty();

  test('should call [AuthenticationRepository.createUser]', () async {
    //Arrange
    //STUB
    when(
      () => repository.createUser(
        name: any(named: "name"),
        avatar: any(named: "avatar"),
        createdAt: any(named: "createdAt"),
      ),
    ).thenAnswer((_) async => const Right(null));

    //Acts
    //* usecase.call
    final result = await usecase(params);

    //Assert
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.createUser(
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
