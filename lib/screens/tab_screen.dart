import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../config/colors.dart';
import 'home_screen.dart';
import 'paid_books.dart';
import 'search_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
   List<Widget>? _pages;
  @override
  void initState() {
    _pages = [
      const HomeScreen(),
      const SearchScreen(),
      const PaidBooks()
    ];
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
      body: _pages![currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: primaryColor,
        currentIndex: currentIndex,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyLight.search), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.wallet), label: ''),
        ],
      ),
    );
  }
}
