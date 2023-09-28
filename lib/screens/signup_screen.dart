import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import '../widgets/text_form_design.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _authData = {'email': '', 'password': '', 'username': ''};
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
                      'Create an account',
                      style: headerOne.copyWith(color: primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: primaryLabel.copyWith(color: Colors.grey)),
                        TextButton(
                            child: Text('Log in',
                                style:
                                    primaryLabel.copyWith(color: primaryColor)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
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
                              'Username',
                              style: headerOne,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              // width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteSoft, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: whiteSoft,
                              ),

                              // Username
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Text(
                              'Email',
                              style: headerOne,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              // width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteSoft, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: whiteSoft,
                              ),

                              // Email input field
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 15),
                                  border: InputBorder.none,
                                ),
                                onSaved: (value) {
                                  setState(() {
                                    _authData['email'] = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Password',
                              style: headerOne,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              // width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteSoft, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: whiteSoft,
                              ),

                              // Password input field
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  // hintText: 'Password',
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 15),
                                  border: InputBorder.none,
                                ),
                                onSaved: (value) {
                                  setState(() {
                                    _authData['password'] = value!;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: double.infinity,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    textStyle: primaryLabel),
                                onPressed: () {},
                                child: const Text('Sign up'),
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
