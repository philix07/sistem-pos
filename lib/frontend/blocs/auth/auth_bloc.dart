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
        emit(AuthLoggedIn(user: data));
      });
    });

    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());

      var user = AppUser(
        uid: '',
        email: event.email,
        name: event.username,
        role: UserRole.none,
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
        emit(AuthLoggedIn(user: data));
      });
    });

    on<AuthLogOut>((event, emit) async {
      emit(AuthLoggedOut());
    });

    on<FetchCurrentUserData>((event, emit) async {
      emit(AuthLoading());
      emit(AuthLoggedIn(user: appUser));
    });
  }
}
