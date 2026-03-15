import 'dart:convert';

import 'package:bloc_tdd/src/authentication/data/data.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:http/http.dart' as http;

const kCreateUserEndpoint = '/users';
const kGetUsersEndpoint = '/users';

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      final body = jsonEncode({
        "name": name,
        "avatar": avatar,
        "createdAt": createdAt,
      });

      final response = await _client.post(
        Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
        body: body,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kGetUsersEndpoint'),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final List<DataMap> list = List<Map<String, dynamic>>.from(
        jsonDecode(response.body),
      );

      final result = list.map((item) => UserModel.fromMap(item)).toList();

      return result;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
