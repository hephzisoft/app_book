import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_check.dart';
import 'config/theme.dart';
import 'firebase_options.dart';
import 'models/providers/auth_provider.dart';
import 'models/providers/book_providers.dart';
import 'screens/book_details_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/tab_screen.dart';
// import 'screens/splash_screen.dart';
// import 'screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<BookProvider>(
            create: (context) => BookProvider(),
          ),
        ],
        child: MaterialApp(
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (ctx) => const AuthCheck(),
            TabScreen.routeName: (ctx) => const TabScreen(),
            BookDetailsScreen.routeName: (ctx) => const BookDetailsScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            SignupScreen.routeName: (ctx) => const SignupScreen(),
          },
          theme: AppTheme.theme,
        ));
  }
}
