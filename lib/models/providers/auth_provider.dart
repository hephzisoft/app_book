import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../user.dart';

class AuthProvider {
  final _firebaseAuth =
      auth.FirebaseAuth.instance; // Getting the firebase auth instance.

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email!,
      name: user.displayName!,
    );
  } // This is used to represent the user from firebase to the current user of our application.

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  } // This is used to get the user state if the user is logged in or signed up or signed out.

  Future<User?> signUp(
      {required String email,
      required String name,
      required String password,
      required Function(String) showErrorSnackbar}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      credential.user!.updateDisplayName(name);
      return _userFromFirebase(credential.user);
    } catch (error) {
      showErrorSnackbar(error.toString());
    }
    return null;
  } //  This is used to signup the user to firebase using the firebase

  Future<User?> login(
      {required String email,
      required String password,
      required Function(String) showErrorSnackbar}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebase(credential.user);
    } catch (error) {
      showErrorSnackbar(error.toString());
    }
    return null;
  } // this is used to log the user into the application

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  } // This is used to sign the user out of the application

  Future<void> sendEmailVerification(
      {required auth.User user,
      required Function(String) showErrorSnackbar}) async {
    try {
      await user.sendEmailVerification();
    } catch (error) {
      showErrorSnackbar(error.toString());
    }
  } //  Sending email verification to the user in order to make sure they actually own the email.

  Future<void> passwordReset(
      {required String email,
      required Function(String) showErrorSnackbar}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  } // This is for checking if the user has forgotten password.
}
