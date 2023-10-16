import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'config/colors.dart';
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
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ConnectivityResult? result = snapshot.data;



          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
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
              },
            );
          } else {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/no_signal.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'You need to make sure that you are connected.',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(
                color: primaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}
