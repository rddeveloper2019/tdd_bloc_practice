import '../utils/typedef.dart';

abstract class UsecaseWithParams<ReturnType, Params> {
  const UsecaseWithParams();
  ResultFuture<ReturnType> call(Params params);
}

abstract class UsecaseWithoutParams<ReturnType> {
  const UsecaseWithoutParams();

  ResultFuture<ReturnType> call();
}
