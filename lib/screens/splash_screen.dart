import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/typography.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset('assets/images/img1.png'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Container(
                  height: 294,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 34),
                    child: Column(
                      children: [
                        Text(
                          'Learn On Your Own',
                          style: headerOne,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Have Access to  A lot of books online',
                          style: paragraph,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: botton_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)

                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 25)
                          ),
                          onPressed: () {},
                          child: Text(
                            'Get Started',
                            style: primaryLabel,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            'Sign In',
                            style: secondaryLabel,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
