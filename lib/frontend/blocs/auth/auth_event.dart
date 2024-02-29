part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String username;

  AuthRegister({
    required this.email,
    required this.password,
    required this.username,
  });
}

class AuthLogOut extends AuthEvent {}

class FetchCurrentUserData extends AuthEvent {}
