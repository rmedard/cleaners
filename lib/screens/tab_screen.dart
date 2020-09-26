import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:cleaners/models/dto/reservation_search_criteria.dart';
import 'package:flutter/material.dart';

import 'tabs/home.dart';
import 'tabs/reservations.dart';
import 'tabs/profile.dart';

class TabScreen extends StatefulWidget {
  static const String id = 'tabbed_pages_screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<TabPage> tabPages = [
    TabPage(widget: Home(), title: 'House Cleaners Services'),
    TabPage(widget: Reservations(), title: 'Reservations'),
    TabPage(widget: Profile(), title: 'Profile'),
  ];

  final AuthService _authService = AuthService();
  int _currentIndex = 0;
  ReservationSearchCriteria searchCriteria;
  LoggedInUser loggedInUser;

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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
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
                selectedItemColor: Theme.of(context).accentColor,
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.white70,
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
                    title: Text('Reservations'),
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
      ),
    );
  }
}

class TabPage {
  String title;
  Widget widget;

  TabPage({this.title, @required this.widget});
}
