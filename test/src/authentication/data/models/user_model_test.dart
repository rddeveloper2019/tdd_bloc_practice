import 'dart:convert';

import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as DataMap;
  final tModel = UserModel.empty();

  test('[UserModel] should be a subclass of [User] entity.', () {
    expect(tModel, isA<User>());
  });

  group('Should return correct data after transforms', () {
    test('fromMap', () {
      final userModel = UserModel.fromMap(tMap);
      expect(userModel, equals(tModel));
    });

    test('toMap', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });

    test('fromJson', () {
      final userModel = UserModel.fromJson(tJson);
      expect(userModel, equals(tModel));
    });

    test('toJson', () {
      final result = tModel.toJson();

      for (var entry in tMap.entries) {
        expect(result.contains(entry.key), true);
        expect(result.contains(entry.value), true);
      }
    });

    test('copyWith', () {
      final tModel2 = UserModel.empty();
      final tModel3 = tModel.copyWith();

      //assert that UserModel.empty() returns same object
      expect(tModel2, equals(tModel));
      //assert that copyWith returns new object
      expect(tModel3 == tModel, false);
    });
  });
}
