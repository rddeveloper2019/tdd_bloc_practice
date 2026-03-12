import 'dart:convert';

import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDatasource remoteDatasource;

  setUpAll(() {
    client = MockClient();
    remoteDatasource = AuthenticationRemoteDatasourceImpl(client);
  });

  group('createUser', () {
    final name = 'test.name';
    final avatar = 'test.avatar';
    final createdAt = 'test.createdAt';
    test(
      'should complete [AuthenticationRemoteDatasource.createUser] successfully with status 200 or 201',
      () async {
        when(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        await remoteDatasource.createUser(
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              "name": name,
              "avatar": avatar,
              "createdAt": createdAt,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [AuthenticationRemoteDatasource.createUser] ApiException when status is not 200 or 201',
      () async {
        when(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Invalid data', 400));

        final methodCall = remoteDatasource.createUser;

        expect(
          () async => await methodCall(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          ),
          throwsA(ApiException(message: 'Invalid data', statusCode: 400)),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              "name": name,
              "avatar": avatar,
              "createdAt": createdAt,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
