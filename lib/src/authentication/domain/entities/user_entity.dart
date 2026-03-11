import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  factory User.empty() {
    return User(
      id: "1",
      createdAt: "_empty.createdAt",
      name: "_empty.name",
      avatar: "_empty.avatar",
    );
  }

  @override
  List<Object> get props => [id, createdAt, name, avatar];

  User copyWith({String? id, String? createdAt, String? name, String? avatar}) {
    return User(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  String toString() {
    return 'User{id=$id, createdAt=$createdAt, name=$name, avatar=$avatar}';
  }
}
