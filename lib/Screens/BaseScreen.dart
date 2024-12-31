import 'package:birthday_calendor/Components/BottomNavBar.dart';
import 'package:birthday_calendor/Screens/CalendorScreen.dart';
import 'package:birthday_calendor/Screens/CreateBirthdayScreen.dart';
import 'package:birthday_calendor/Screens/PostcardScreen.dart';
import 'package:birthday_calendor/Screens/SearchScreen.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static _HomeScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeScreenState>();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens to display based on the selected index
  final List<Widget> _screens = [
    MainScreen(),
    CalendorScreen(),
    CreateBirthdayScreen(),
    PostcardScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Update the selected index when tapping a bottom nav item
    });
  }

  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index from DayScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[
            _selectedIndex], // Display the screen based on the selected index
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
