import 'package:ebook/pages/explore.dart';
import 'package:ebook/pages/favorite_books.dart';
import 'package:ebook/pages/home_page.dart';
import 'package:ebook/pages/profile.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  _BaseWidgetState createState() => _BaseWidgetState();

  static final GlobalKey<_BaseWidgetState> changePageKey =
      GlobalKey<_BaseWidgetState>();
}

class _BaseWidgetState extends State<BaseWidget> {
  int _selectedIndex = 0;

  // List of widgets to use as different pages
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ExplorePage(), // Replace with actual screen
    FavoritePage(), // Replace with actual screen
    ProfilePage(), // Replace with actual screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Public method to change the page
  void changePage(int index) {
    if (index >= 0 && index < _widgetOptions.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions
              .elementAt(_selectedIndex), // Display the selected screen
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.black),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.black),
              label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _selectedIndex == 2
                      ? Colors.blue
                      : const Color.fromARGB(255, 17, 13, 13)),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,
                  color: _selectedIndex == 3 ? Colors.blue : Colors.black),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
