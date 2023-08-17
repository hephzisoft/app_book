import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const HomeScreen(),
      },
      theme: AppTheme.theme
    );
  }
}

