import 'dart:convert';

import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: "1",
      createdAt: "_empty.createdAt",
      name: "_empty.name",
      avatar: "_empty.avatar",
    );
  }

  DataMap toMap() => {
    "id": id,
    "createdAt": createdAt,
    "name": name,
    "avatar": avatar,
  };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object> get props => [id, createdAt, name, avatar];
}
