import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import '../widgets/text_form_design.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.35,
            ),
            Container(
              height: constraints.maxHeight * 0.65,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back!',
                      style: headerOne.copyWith(color: primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? ',
                            style: primaryLabel.copyWith(color: Colors.grey)),
                        TextButton(
                            child: Text('Register',
                                style:
                                    primaryLabel.copyWith(color: primaryColor)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignupScreen.routeName);
                            }),
                      ],
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: headerOne,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const TextFormDesign(),
                            const SizedBox(height: 20),
                            Text(
                              'Password',
                              style: headerOne,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const TextFormDesign(),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: TextButton(
                                child: Text(
                                  'Forget password?',
                                  style: primaryLabel.copyWith(
                                      color: primaryColor),
                                  // textAlign: TextAlign.start,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    textStyle: primaryLabel),
                                onPressed: () {},
                                child: const Text('Log in'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
