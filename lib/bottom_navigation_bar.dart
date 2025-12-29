import 'package:bloge/features/home/presentation/home_screen.dart';

import 'package:bloge/features/bookmark/presentation/bookmark_screen.dart';
import 'package:bloge/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _selectedindex = 0;
  void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List<Widget> _page = const [Home(), BookmarksPage(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121217),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Color(0xFF121217),
        currentIndex: _selectedindex,
        onTap: _navigator,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF9EA6BA),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_outlined),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: IndexedStack(index: _selectedindex, children: _page),
    );
  }
}
