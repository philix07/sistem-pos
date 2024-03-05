import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/data/repository/auth_repository.dart';
import 'package:kerja_praktek/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();
  var appUser = AppUser.dummy();

  AuthBloc() : super(AuthLoggedOut()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());

      var result = await _authRepository.signInUser(
        emailController: event.email,
        passwordController: event.password,
      );

      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        appUser = data;
        if (appUser.role == UserRole.none) {
          emit(AuthNewUser());
        } else {
          appUser = data;
          emit(AuthLoggedIn(user: appUser));
        }
      });
    });

    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());

      var user = AppUser(
        uid: '',
        email: event.email,
        name: event.username,
        role: UserRole.none,
        createdAt: DateTime.now(),
      );

      var result = await _authRepository.registerUser(
        emailController: event.email,
        passwordController: event.password,
        user: user,
      );

      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        appUser = data;
        emit(AuthNewUser());
      });
    });

    on<AuthLogOut>((event, emit) async {
      await _authRepository.signOutUser();
      emit(AuthLoggedOut());
    });

    on<AuthInitial>((event, emit) async {
      emit(AuthLoading());

      //* Check if there is any user is currently authenticated
      var result = await _authRepository.isAuthenticated();
      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        if (data.uid == AppUser.dummy().uid) {
          emit(AuthLoggedOut());
        } else if (data.role == UserRole.none) {
          emit(AuthNewUser());
        } else {
          appUser = data;
          emit(AuthLoggedIn(user: data));
        }
      });
    });

    on<AuthFetchLocalUser>((event, emit) async {
      emit(AuthLoading());
      
      if (appUser.role != UserRole.none) {
        emit(AuthLoggedIn(user: appUser));
      } else {
        emit(AuthLoggedOut());
      }
    });

    
  }
}
