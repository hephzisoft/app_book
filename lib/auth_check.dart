import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth_provider.dart';
import 'models/user.dart';
// import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/verify_email_screen.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
   Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context);
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return const SplashScreen();
            } else {
              return const VerifyEmailScreen();
            }
          } else {
            return const Scaffold(
              body: Center(child: CupertinoActivityIndicator()),
            );
          }
        });
  }
}
