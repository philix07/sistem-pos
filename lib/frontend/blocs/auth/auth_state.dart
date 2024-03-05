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

final class AuthNewUser extends AuthState {}

final class AuthUserDataFetched extends AuthState {
  final List<AppUser> users;

  AuthUserDataFetched({required this.users});
}