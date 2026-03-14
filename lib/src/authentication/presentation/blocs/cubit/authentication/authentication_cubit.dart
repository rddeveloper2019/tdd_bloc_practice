import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required this.createUserUsecase,
    required this.getUsersUsecase,
  }) : super(const AuthenticationInitial());

  final CreateUserUsecase createUserUsecase;
  final GetUsersUsecase getUsersUsecase;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUserState());

    final result = await createUserUsecase(
      CreateUserParams(createdAt: createdAt, name: name, avatar: avatar),
    );

    result.fold(
      (Failure error) {
        emit(AuthenticationErrorState(message: error.errorMessage));
      },
      (_) {
        emit(const CreatedUserState());
      },
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsersState());

    final result = await getUsersUsecase();
    result.fold(
      (Failure error) {
        emit(AuthenticationErrorState(message: error.errorMessage));
      },
      (List<User> users) {
        emit(LoadedUsersState(users: users));
      },
    );
  }
}
