import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import '../widgets/text_form_design.dart';

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
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
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
                          onPressed: () {}),
                    ],
                  ),
                  const Form(
                    child: Column(
                      children: [
                        Text('Email'),
                        // TextFormDesign(),
                        TextFormDesign(),
                        TextFormDesign(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
