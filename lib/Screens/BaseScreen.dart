import 'package:birthday_calendor/Components/BottomNavBar.dart';
import 'package:birthday_calendor/Screens/CalendorScreen.dart';
import 'package:birthday_calendor/Screens/CreateBirthdayScreen.dart';
import 'package:birthday_calendor/Screens/PostcardScreen.dart';
import 'package:birthday_calendor/Screens/SearchScreen.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class BaseScreen extends StatelessWidget {
  final String deviceName;

  const BaseScreen({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(deviceName: deviceName),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String deviceName;

  const HomeScreen({Key? key, required this.deviceName}) : super(key: key);

  static _HomeScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeScreenState>();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens to display based on the selected index
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();

    // Add the MainScreen with the deviceName passed correctly
    _screens.add(
        MainScreen(deviceName: widget.deviceName)); // Use widget.deviceName
    _screens.add(CalendorScreen());
    _screens.add(CreateBirthdayScreen());
    _screens.add(PostcardScreen());
    _screens.add(SearchScreen());
  }

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
      ),
    );
  }
}
