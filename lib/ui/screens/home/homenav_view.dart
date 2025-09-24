import 'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/home/home_view.dart';
import 'package:novel_truck/ui/screens/novel/novel_view.dart';
import 'package:novel_truck/ui/screens/profile/profile_view.dart';
import 'package:novel_truck/ui/screens/record/record_view.dart';
import 'package:novel_truck/ui/screens/search/search_view.dart';
import 'package:provider/provider.dart';


class HomeNav extends StatelessWidget {
  final List<Widget> _pages = [
    Record(),
    Novel(),
    Home(),
    Search(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<HomeNavProvider>();

    return Scaffold(
      body: _pages[navProvider.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.index,
        onTap: (i) => navProvider.setIndex(i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Novel'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}


class HomeNavProvider extends ChangeNotifier {
  int _index = 2; // 기본 인덱스
  int get index => _index;

  void setIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}