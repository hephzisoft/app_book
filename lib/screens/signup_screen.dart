import 'package:app_book/exceptions/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import '../models/providers/auth_provider.dart';
import 'login_screen.dart';
import 'verify_email_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _authData = {'email': '', 'password': '', 'username': ''};
  final _formKey = GlobalKey<FormState>(); // This is for validating
  void register() async {
    try {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();
      if (_authData['password'] == null &&
          _authData['email'] == null &&
          _authData['username'] == null) {
        return;
      }
      await Provider.of<AuthProvider>(context, listen: false)
          .signUp(
            email: _authData['email']!,
            name: _authData['username']!,
            password: _authData['password']!,
          )
          .then((value) => Navigator.of(context)
              .pushReplacementNamed(VerifyEmailScreen.routeName));
    } on AuthException catch(error) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

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
                      key: _formKey,
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
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (value.length < 3) {
                                      return 'Are you sure that your name is this short';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['username'] = value!;
                                },
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
                                  _authData['email'] = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (!value.contains('@')) {
                                      return 'Please enter a valid email address.';
                                    }
                                  } else {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
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
                                obscureText: true,
                                decoration: const InputDecoration(
                                  // hintText: 'Password',
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 15),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    if (value.length < 8) {
                                      return 'Password must be greater than 8 character';
                                    }
                                  } else {
                                    return 'Please enter a password.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['password'] = value!;
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
                                onPressed: () {
                                  register();
                                },
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
