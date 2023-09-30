// import 'package:app_book/models/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import '../models/providers/auth_provider.dart';
import 'signup_screen.dart';
import 'tab_screen.dart';
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

  void login() async {
    final isValid = _formKey.currentState!.validate();
    var haveError = false;
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    if (_authData['email'] == null && _authData['password'] == null) {
      return;
    }
    await Provider.of<AuthProvider>(context, listen: false)
        .login(
      email: _authData['email']!,
      password: _authData['password']!,
      showErrorSnackbar: (error) {
        if (error.isEmpty) {
          haveError = false;
        }
        // This is used for checking if error is empty then calling haveError to false.
        else {
          haveError = true;
          String errorMessage = error.replaceAll(RegExp(r'\[[^\]]*\]'),
              ''); // This is used for removing [] and its internal content.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          ); // For showing the error using a snackbar.
        }
      },
    )
        .then((_) {
      if (!haveError) {
        Navigator.of(context).pushReplacementNamed(VerifyEmailScreen.routeName);
      }
    }); // making sure that if there is no error then we can move to the verify_email_screen.
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
                                  login();
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
