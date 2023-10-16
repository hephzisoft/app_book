import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';

import '../services/auth_provider.dart';
import 'favorite_book_screen.dart';
import 'free_books_screen.dart';
import 'login_screen.dart';
import 'paid_books_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const routeName = '/tab';
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget>? _pages;

  @override
  void initState() {
    _pages = [const FreeBooks(), const PaidBooks(), const FavoriteBooks()];

    super.initState();
  }

  var currentIndex = 0;
  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false)
                  .signOut()
                  .then((value) =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName));
            },
          )
        ],
      ),
      body: _pages![currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: currentIndex,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.wallet), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.heart), label: ''),
        ],
      ),
    );
  }
}
