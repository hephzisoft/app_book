import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import '../models/auth_result_status.dart';
import '../models/user.dart';
import 'auth_exception_handler.dart';

class AuthProvider extends ChangeNotifier {
  final _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }

    return User(
        uid: user.uid, email: user.email!, name: user.displayName ?? '');
  }

  String? get userId {
    return _firebaseAuth.currentUser?.uid;
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  AuthResultStatus? _status;

  ///
  /// Helper Functions
  ///

  Future<AuthResultStatus> createAccount({email, pass, name}) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {
        _userFromFirebase(authResult.user);
        authResult.user?.updateDisplayName(name);

        _status = AuthResultStatus.successful;
        notifyListeners();
      }
    } on auth.FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  Future<AuthResultStatus> login({email, pass}) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);

      if (authResult.user != null) {
        _userFromFirebase(authResult.user);
        _status = AuthResultStatus.successful;
        notifyListeners();
      }
    } on auth.FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  Future<void> signOut() async {
    _userFromFirebase(null);
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<AuthResultStatus> sendEmailVerification(
      {required auth.User user,
      required Function(String) showErrorSnackbar}) async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  Future<void> passwordReset({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (error) {
      throw AuthExceptionHandler.handleException(error);
    }
  }
}
