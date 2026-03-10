import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  factory User.empty() {
    return User(
      id: 1,
      createdAt: "_empty.createdAt",
      name: "_empty.name",
      avatar: "_empty.avatar",
    );
  }
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}
