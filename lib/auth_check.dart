import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/providers/auth_provider.dart';
import 'models/user.dart';
// import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/tab_screen.dart';
import 'screens/verify_email_screen.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return StreamBuilder(
        stream: auth.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const SplashScreen();
            } else {
              return const VerifyEmailScreen();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
        });
  }
}
