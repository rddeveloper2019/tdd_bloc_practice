import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAAuthenticationRemoteDatasource extends Mock
    implements AuthenticationRemoteDatasource {}

void main() {
  late AuthenticationRemoteDatasource remoteDatasource;
  late AuthenticationRepositoryImpl authRepo;

  setUpAll(() {
    remoteDatasource = MockAAuthenticationRemoteDatasource();
    authRepo = AuthenticationRepositoryImpl(remoteDatasource);
  });

  tearDown(() {
    verifyNoMoreInteractions(remoteDatasource);
  });

  final tException = ApiException(
    message: 'Unknown error occurred',
    statusCode: 500,
  );

  group('createUser', () {
    final name = 'test.name';
    final avatar = 'test.avatar';
    final createdAt = 'test.createdAt';

    test(
      'should call [AuthenticationRemoteDatasource.createUser] successfully',
      () async {
        //arrange
        when(
          () => remoteDatasource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt'),
          ),
        ).thenAnswer((_) async => Future.value());

        //act
        final result = await authRepo.createUser(
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        );

        //assert
        expect(result, equals(const Right(null)));

        verify(
          () => remoteDatasource.createUser(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          ),
        ).called(1);
      },
    );
    test(
      'should return [ApiFailure] when [AuthenticationRemoteDatasource.createUser] called unsuccessfully',
      () async {
        //arrange
        when(
          () => remoteDatasource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt'),
          ),
        ).thenThrow(tException);

        //act
        final result = await authRepo.createUser(
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        );

        //assert
        expect(result, equals(Left(ApiFailure.fromApiException(tException))));

        verify(
          () => remoteDatasource.createUser(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          ),
        ).called(1);
      },
    );
  });

  group('getUsers', () {
    tearDown(() {
      verify(() => remoteDatasource.getUsers()).called(1);
    });

    test(
      'should call [AuthenticationRemoteDatasource.getUsers] successfully and return [List<User>]',
      () async {
        when(
          () => remoteDatasource.getUsers(),
        ).thenAnswer((_) async => Future.value([]));

        final result = await authRepo.getUsers();

        //assert
        expect(result, isA<Right<dynamic, List<dynamic>>>());
      },
    );
    test(
      'should return [ApiFailure] when [AuthenticationRemoteDatasource.getUsers] called unsuccessfully',
      () async {
        when(() => remoteDatasource.getUsers()).thenThrow(tException);

        final result = await authRepo.getUsers();

        //assert
        expect(result, equals(Left(ApiFailure.fromApiException(tException))));
      },
    );
  });
}
