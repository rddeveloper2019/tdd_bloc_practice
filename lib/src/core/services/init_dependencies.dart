import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/authentication/presentation/blocs/cubit/authentication/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl
    //presentation
    ..registerFactory(
      () => AuthenticationCubit(
        createUserUsecase: sl<CreateUserUsecase>(),
        getUsersUsecase: sl<GetUsersUsecase>(),
      ),
    )
    //usecases
    ..registerLazySingleton<CreateUserUsecase>(
      () => CreateUserUsecase(sl<AuthenticationRepository>()),
    )
    ..registerLazySingleton<GetUsersUsecase>(
      () => GetUsersUsecase(sl<AuthenticationRepository>()),
    )
    //repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl<AuthenticationRemoteDatasource>()),
    )
    //datasources
    ..registerLazySingleton<AuthenticationRemoteDatasource>(
      () => AuthenticationRemoteDatasourceImpl(sl<http.Client>()),
    )
    //external depends
    ..registerLazySingleton<http.Client>(http.Client.new);
}
