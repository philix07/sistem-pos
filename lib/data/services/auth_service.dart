import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kerja_praktek/models/user.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userRef = FirebaseFirestore.instance.collection('users');

  Future<Either<String, AppUser>> registerUser({
    required String emailController,
    required String passwordController,
    required AppUser user,
  }) async {
    try {
      print('creating user...');
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
      print('User Created');

      // Set the user id to match the firebase auth user id
      var newUser = AppUser(
        uid: _firebaseAuth.currentUser!.uid,
        email: user.email,
        name: user.name,
        role: user.role,
      );

      // TODO: Add User Data Into Collection
      // If There's Error While Inputing Data Into The DB
      // Then Delete The User
      await _userRef.doc(_firebaseAuth.currentUser!.uid).set(newUser.toMap());

      return Right(newUser);
    } catch (e) {
      print(e);
      return const Left('Failed To Register Your Account');
    }
  }

  Future<Either<String, AppUser>> signInUser({
    required String emailController,
    required String passwordController,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      var userId = _firebaseAuth.currentUser!.uid;
      var doc = await _userRef.doc(userId).get();
      var data = doc.data() as Map<String, dynamic>;

      var appUser = AppUser.fromMap(data);
      return Right(appUser);
    } catch (e) {
      return const Left('User Not Found');
    }
  }

  Future<String> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'Successfully Signed Out';
    } catch (e) {
      return 'Failed to Sign Out';
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Link Sent';
    } catch (e) {
      return 'Email Not Found';
    }
  }
}
