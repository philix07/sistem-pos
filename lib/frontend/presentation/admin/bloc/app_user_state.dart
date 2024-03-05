part of 'app_user_bloc.dart';

sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserDataFetched extends AppUserState {
  final List<AppUser> users;

  AppUserDataFetched({required this.users});
}

final class AppUserLoading extends AppUserState {}

final class AppUserError extends AppUserState {
  final String message;

  AppUserError({required this.message});
}

final class AppUserUpdated extends AppUserState {}
