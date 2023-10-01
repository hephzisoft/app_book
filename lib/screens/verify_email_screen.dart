import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../services/auth_provider.dart';

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

  // @override
  // void initState() {
  //   if (user == null) {
  //     print('User is null');
  //     // Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  //   }
  //   isEmailVerified = user!.emailVerified;
  //   if (!isEmailVerified) {
  //     Provider.of<AuthProvider>(context, listen: false).sendEmailVerification(
  //       user: user!,
  //       showErrorSnackbar: (error) {
  //         String errorMessage = error.replaceAll(RegExp(r'\[[^\]]*\]'), '');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(errorMessage)),
  //         );
  //       },
  //     );
  //     timer = Timer.periodic(
  //       const Duration(seconds: 4),
  //       (timer) => checkEmailVerified(),
  //     );
  //   }
  //   super.initState();
  // }

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
    final email = user?.email;
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size * 0.4,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  width: double.infinity,
                  child: Image.asset('assets/images/email.png'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  height: size * 0.38,
                  child: Column(
                    children: [
                      Text(
                        'We have sent you an email',
                        style: GoogleFonts.montserrat(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Text(
                          'Click on the email verrification link sent to you on $email.',
                          style: GoogleFonts.montserrat(fontSize: 17),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Didn\'t recieve the email yet?',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          TextButton(
                            onPressed: () {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .sendEmailVerification(
                                user: user!,
                                showErrorSnackbar: (error) {
                                  String errorMessage = error.replaceAll(
                                      RegExp(r'\[[^\]]*\]'), '');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errorMessage)),
                                  );
                                },
                              );
                            },
                            child: Text('Resend it',
                                style: GoogleFonts.montserrat(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)),
                        onPressed: () {},
                        child: Text('Open Email App',
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Note: Please check spam folder if you could not find the mail.',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
