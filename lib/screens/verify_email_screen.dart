import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/auth_provider.dart';

import 'login_screen.dart';
import 'tab_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  static const routeName = '/verify-screen';

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  var isEmailVerified = false;
  final user = FirebaseAuth.instance.currentUser;
  Timer? timer;
  @override
  void initState() {
    if (user == null) {
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    }
    isEmailVerified = user!.emailVerified;
    if (!isEmailVerified) {
      Provider.of<AuthProvider>(context, listen: false).sendEmailVerification(
        user: user!,
        showErrorSnackbar: (error) {
          String errorMessage = error.replaceAll(RegExp(r'\[[^\]]*\]'), '');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        },
      );
      timer = Timer.periodic(
        const Duration(seconds: 4),
        (timer) => checkEmailVerified(),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: isEmailVerified
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Image.asset(
                      'assets/images/verify.png',
                    ),
                  ),
                  const Text('Welcome to this application'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(TabScreen.routeName);
                    },
                    child: const Text('Explore the home page.'),
                  )
                ],
              ),
            )
          : Column(
              children: [
                const Text('You are not verified yet....'),
                TextButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .sendEmailVerification(
                      user: user!,
                      showErrorSnackbar: (error) {
                        String errorMessage =
                            error.replaceAll(RegExp(r'\[[^\]]*\]'), '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      },
                    );
                  },
                  child: const Text('Resend Email Confirmation'),
                )
              ],
            ),
    );
  }
}
