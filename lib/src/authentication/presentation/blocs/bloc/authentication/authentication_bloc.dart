import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.createUserUsecase,
    required this.getUsersUsecase,
  }) : super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUser);
    on<GetUsersEvent>(_getUsers);
  }

  final CreateUserUsecase createUserUsecase;
  final GetUsersUsecase getUsersUsecase;

  Future<void> _createUser(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUserState());

    final result = await createUserUsecase(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
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

  Future<void> _getUsers(
    GetUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
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
