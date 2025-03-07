import 'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/home/home_view.dart';
import 'package:novel_truck/ui/screens/novel/novel_view.dart';
import 'package:novel_truck/ui/screens/profile/profile_view.dart';
import 'package:novel_truck/ui/screens/record/record_view.dart';
import 'package:novel_truck/ui/screens/search/search_view.dart';


class HomeNav extends StatefulWidget {
   HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  var _index = 1;
  List _pages = [
    Record(),
    Novel(),
    Home(),
    Search(),
    Profile(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt),
              label: 'Record',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Novel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}
