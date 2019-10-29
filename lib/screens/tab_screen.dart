import 'package:flutter/material.dart';

import 'tabs/home.dart';
import 'tabs/plannings.dart';
import 'tabs/profile.dart';

class TabScreen extends StatefulWidget {
  static const String id = 'tabbed_pages_screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<TabPage> tabPages = [
    TabPage(widget: Home(), title: 'House Cleaners Services'),
    TabPage(widget: Plannings(), title: 'Plannings'),
    TabPage(widget: Profile(), title: 'Profile'),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tabPages[_currentIndex].title,
          style: TextStyle(
            color: Color(0xFFFED330),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: tabPages[_currentIndex].widget,
            ),
            BottomNavigationBar(
              onTap: (int index) {
                setState(
                  () {
                    if (_currentIndex != index) {
                      _currentIndex = index;
                    }
                  },
                );
              },
              currentIndex: _currentIndex,
              selectedItemColor: Color(0xFFFED330),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.work,
                  ),
                  title: Text('Services'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.timer,
                  ),
                  title: Text('Plannings'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  title: Text('Profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TabPage {
  String title;
  Widget widget;

  TabPage({this.title, @required this.widget});
}
