import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_result_status.dart';
import '../models/user.dart';
import 'auth_exception_handler.dart';

class AuthProvider {
  final _firebaseAuth = auth.FirebaseAuth.instance;
  String? _userId;
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    _userId = user.uid;
    return User(uid: user.uid, email: user.email!, name: user.displayName ?? ''
        // name: user.displayName as String,
        );
  }

  String? get userId {
    return _userId;
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
      }
    } on auth.FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
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
    } on auth.FirebaseAuthException {
      //
    }
  }
}
