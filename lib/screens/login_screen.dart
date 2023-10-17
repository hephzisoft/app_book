import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import '../models/auth_result_status.dart';
import '../services/auth_exception_handler.dart';
import '../services/auth_provider.dart';
import 'signup_screen.dart';
import 'verify_email_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authData = {
    'email': '',
    'password': '',
  };
  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Login Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }

  void passwordReset() async {
    try {
      final isValid = _formKey.currentState!.validate();

      if (!isValid) {
        return;
      }

      _formKey.currentState!.save();

      if (_authData['email'] == null) {
        return;
      }
      await Provider.of<AuthProvider>(context)
          .passwordReset(email: _authData['email']!);
    } on AuthExceptionHandler catch (error) {
      _showAlertDialog(error);
    }
  }

  void login(BuildContext ctx) async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    if (_authData['password'] == null && _authData['email'] == null) {
      return;
    }

    final status =
        await Provider.of<AuthProvider>(context, listen: false).login(
      email: _authData['email']!,
      pass: _authData['password']!,
    );
    if (status == AuthResultStatus.successful) {
      Navigator.of(ctx).pushReplacementNamed(VerifyEmailScreen.routeName);
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      _showAlertDialog(errorMsg);
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
                      key: _formKey,
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
                            Container(
                              // width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteSoft, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: whiteSoft,
                              ),

                              // email text field
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 15),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  _authData['email'] = value!;
                                },
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

                              // password text field

                              child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 20, top: 15),
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    _authData['password'] = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      if (value.length < 8) {
                                        return 'Password must be greater than 8 character';
                                      }
                                    } else {
                                      return 'Please enter a password.';
                                    }
                                    return null;
                                  }),
                            ),
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
                                onPressed: () {
                                  login(context);
                                },
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
