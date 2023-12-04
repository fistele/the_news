import 'package:flutter/material.dart';

import '../config/colors.dart';
import 'discover_screen.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'search_screen.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    const HomeScreen(),
    const DiscoverScreen(),
    const LibraryScreen(),
    const SearchScreen()
  ];
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.black800,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: currentindex,
          elevation: 0.2,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Découvrir',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              label: 'Bibliothèque',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Recherche',
            ),
          ],
        ),
      ),
    );
  }
}
