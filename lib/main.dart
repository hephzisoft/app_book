import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';
import 'models/providers/book_providers.dart';
import 'screens/book_details_screen.dart';
import 'screens/tab_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BookProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const TabScreen(),
          BookDetailsScreen.routeName: (ctx) =>  const BookDetailsScreen(),
        },
        theme: AppTheme.theme,
      ),
    );
  }
}
