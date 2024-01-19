import 'package:flutter/material.dart';
import 'package:flutter_application/about.dart';
import 'package:flutter_application/beranda.dart';
import 'package:flutter_application/search/cari_flim.dart';

class ButtomNav extends StatefulWidget {
  const ButtomNav({super.key});

  @override
  State<ButtomNav> createState() => _ButtomNavState();
}

class _ButtomNavState extends State<ButtomNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Beranda(),
    const CariPage(),
    const About(),
    // // const About(),
    // const Maps(),
    // const About()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.window,
              ),
              label: 'Home',
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Cari',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info,
              ),
              label: 'About',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
