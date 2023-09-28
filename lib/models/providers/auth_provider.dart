import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../user.dart';

class AuthProvider {
  final _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(name: user.displayName!, email: user.email!, uid: user.uid);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signup(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateDisplayName(name);
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification(auth.User? user) async {
    try {
      user!.sendEmailVerification();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
    }
  }
}
