part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final InfoUser infoUser;

  AuthLoaded({required this.infoUser});

  @override
  List<Object> get props => [infoUser];
}

class RegisterSuccess extends AuthState {
  final String email;
  final String verify_code;

  RegisterSuccess({
    required this.verify_code,
    required this.email,
  });
}

class RegisterFailure extends AuthState {
  final String message;
  RegisterFailure(this.message);
}

class GetUserLoading extends AuthState {}

class GetUserLoaded extends AuthState {
  final InfoUser infoUser;

  GetUserLoaded({required this.infoUser});

  @override
  List<Object> get props => [infoUser];
}

class GetUserLoadError extends AuthState {
  final String error;
  GetUserLoadError({required this.error});
}
