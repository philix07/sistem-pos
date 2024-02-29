import 'package:dartz/dartz.dart';
import 'package:kerja_praktek/data/services/auth_service.dart';
import 'package:kerja_praktek/models/user.dart';

class AuthRepository {
  final _authService = AuthService();

  Future<Either<String, AppUser>> signInUser({
    required String emailController,
    required String passwordController,
  }) async {
    var result = await _authService.signInUser(
      emailController: emailController,
      passwordController: passwordController,
    );

    var isError = false;
    var errorMessage = '';
    AppUser userData = AppUser.dummy();

    result.fold((error) {
      isError = true;
      errorMessage = error;
    }, (data) {
      userData = data;
    });

    if (isError) {
      return Left(errorMessage);
    }
    return Right(userData);
  }

  Future<Either<String, AppUser>> registerUser({
    required String emailController,
    required String passwordController,
    required AppUser user,
  }) async {
    var result = await _authService.registerUser(
      emailController: emailController,
      passwordController: passwordController,
      user: user,
    );

    var isError = false;
    var errorMessage = '';
    AppUser userData = AppUser.dummy();

    result.fold((error) {
      isError = true;
      errorMessage = error;
    }, (data) {
      userData = data;
    });

    if (isError) {
      return Left(errorMessage);
    }
    return Right(userData);
  }

  Future<String> signOutUser() async {
    return await _authService.signOutUser();
  }

  Future<String> forgotPassword(String email) async {
    return await _authService.forgotPassword(email);
  }
}
