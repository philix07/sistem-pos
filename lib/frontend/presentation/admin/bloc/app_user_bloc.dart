import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/data/repository/auth_repository.dart';
import 'package:kerja_praktek/models/user.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  final _authRepository = AuthRepository();
  List<AppUser> _users = [];

  AppUserBloc() : super(AppUserInitial()) {
    on<AppUserFetchAllData>((event, emit) async {
      emit(AppUserLoading());

      var result = await _authRepository.fetchAllUserData();
      result.fold((error) {
        emit(AppUserError(message: error));
      }, (data) {
        _users = data;
        emit(AppUserDataFetched(users: _users));
      });
    });

    on<AppUserUpdateRole>((event, emit) async {
      emit(AppUserLoading());

      var result = await _authRepository.updateUserData(
        id: event.uid,
        role: event.role,
      );
      result.fold((error) {
        emit(AppUserError(message: error));
      }, (data) {
        var user = _users.firstWhere((val) => val.uid == event.uid);
        _users.remove(user);

        var modifiedUser = AppUser(
          uid: user.uid,
          email: user.email,
          name: user.name,
          role: event.role,
          createdAt: user.createdAt,
        );
        _users.add(modifiedUser);

        emit(AppUserUpdated());
        emit(AppUserDataFetched(users: _users));
      });
    });
  }
}
