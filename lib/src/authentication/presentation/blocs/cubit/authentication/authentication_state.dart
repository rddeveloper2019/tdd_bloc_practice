part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class CreatingUserState extends AuthenticationState {
  const CreatingUserState();
}

final class CreatedUserState extends AuthenticationState {
  const CreatedUserState();
}

final class GettingUsersState extends AuthenticationState {
  const GettingUsersState();
}

final class LoadedUsersState extends AuthenticationState {
  const LoadedUsersState({required this.users});

  final List<User> users;

  @override
  List<String> get props => users.map((u) => u.id).toList();
}

final class AuthenticationErrorState extends AuthenticationState {
  const AuthenticationErrorState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}
