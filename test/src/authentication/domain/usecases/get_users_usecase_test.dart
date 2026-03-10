import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late GetUsersUsecase usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = GetUsersUsecase(repository);
  });

  final tResponse = [User.empty()];
  test(
    'should call [AuthenticationRepository.getUsers] and should return [List<User>]',
    () async {
      //Arrange
      //STUB
      when(
        () => repository.getUsers(),
      ).thenAnswer((_) async => Right(tResponse));

      //Acts
      //* usecase.call
      final result = await usecase();

      //Assert
      expect(result, equals(Right<dynamic, List<User>>(tResponse)));

      verify(() => repository.getUsers()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
