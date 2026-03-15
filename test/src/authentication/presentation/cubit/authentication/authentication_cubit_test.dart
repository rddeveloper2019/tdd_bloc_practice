import 'package:bloc_tdd/src/authentication/domain/domain.dart';
import 'package:bloc_tdd/src/authentication/presentation/blocs/cubit/authentication/authentication_cubit.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsersUsecase extends Mock implements GetUsersUsecase {}

class MockCreateUserUsecase extends Mock implements CreateUserUsecase {}

void main() {
  late GetUsersUsecase getUsersUsecase;
  late CreateUserUsecase createUserUsecase;
  late AuthenticationCubit authenticationCubit;
  final tCreateUserParams = CreateUserParams.empty();
  final tApiFailure = ApiFailure(message: 'message', statusCode: 400);
  setUp(() {
    getUsersUsecase = MockGetUsersUsecase();
    createUserUsecase = MockCreateUserUsecase();
    authenticationCubit = AuthenticationCubit(
      createUserUsecase: createUserUsecase,
      getUsersUsecase: getUsersUsecase,
    );
  });

  tearDown(() {
    authenticationCubit.close();
  });

  test('initial state should be [AuthenticationInitial] ', () async {
    assert(authenticationCubit.state == const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUserState] [CreatedUserState] when successful',
      // build: () => AuthenticationCubit(
      //   createUserUsecase: createUserUsecase,
      //   getUsersUsecase: getUsersUsecase,
      // ),
      build: () {
        when(
          () => createUserUsecase(tCreateUserParams),
        ).thenAnswer((_) async => const Right(null));
        return authenticationCubit;
      },
      act: (cubit) {
        cubit.createUser(
          createdAt: tCreateUserParams.createdAt,
          name: tCreateUserParams.name,
          avatar: tCreateUserParams.avatar,
        );
      },
      expect: () => const <AuthenticationState>[
        CreatingUserState(),
        CreatedUserState(),
      ],
      verify: (cubit) {
        verify(() => createUserUsecase(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUserUsecase);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUserState] [AuthenticationErrorState] when unsuccessful',

      build: () {
        when(
          () => createUserUsecase(tCreateUserParams),
        ).thenAnswer((_) async => Left(tApiFailure));
        return authenticationCubit;
      },
      act: (cubit) {
        cubit.createUser(
          createdAt: tCreateUserParams.createdAt,
          name: tCreateUserParams.name,
          avatar: tCreateUserParams.avatar,
        );
      },
      expect: () => <AuthenticationState>[
        CreatingUserState(),
        AuthenticationErrorState(message: tApiFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(() => createUserUsecase(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUserUsecase);
      },
    );
  });

  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsersState] [LoadedUsersState] when successful',

      build: () {
        when(() => getUsersUsecase()).thenAnswer((_) async => const Right([]));
        return authenticationCubit;
      },
      act: (cubit) {
        cubit.getUsers();
      },
      expect: () => const <AuthenticationState>[
        GettingUsersState(),
        LoadedUsersState(users: []),
      ],
      verify: (cubit) {
        verify(() => getUsersUsecase()).called(1);
        verifyNoMoreInteractions(getUsersUsecase);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsersState] [AuthenticationErrorState] when unsuccessful',

      build: () {
        when(
          () => getUsersUsecase(),
        ).thenAnswer((_) async => Left(tApiFailure));
        return authenticationCubit;
      },
      act: (cubit) {
        cubit.getUsers();
      },
      expect: () => <AuthenticationState>[
        GettingUsersState(),
        AuthenticationErrorState(message: tApiFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(() => getUsersUsecase()).called(1);
        verifyNoMoreInteractions(getUsersUsecase);
      },
    );
  });
}
