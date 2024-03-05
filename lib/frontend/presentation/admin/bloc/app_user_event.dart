part of 'app_user_bloc.dart';

sealed class AppUserEvent {}

class AppUserFetchAllData extends AppUserEvent {}

class AppUserUpdateRole extends AppUserEvent {
  final String uid;
  final UserRole role;

  AppUserUpdateRole({required this.role, required this.uid});
}
