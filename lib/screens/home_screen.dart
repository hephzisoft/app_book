import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('This is the book application.'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyLight.search), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.wallet), label: ''),
        ],
      ),
    );
  }
}
