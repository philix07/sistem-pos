part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoggedIn extends AuthState {
  final AppUser user;

  AuthLoggedIn({required this.user});
}

final class AuthLoggedOut extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
