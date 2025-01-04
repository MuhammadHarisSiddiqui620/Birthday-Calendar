import 'package:birthday_calendor/Components/CustomDateTimeline.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String deviceName;
  const MainScreen({super.key, required this.deviceName});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _selectedDate = DateTime(2025, 6, 15); // Initial focused date

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xFFBAC8FF),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${widget.deviceName}!",
              style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF141522),
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Let's choose the right birthday!",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF54577A),
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            CustomDateTimeline(
              firstDate: DateTime(2024, 3, 1),
              lastDate: DateTime(2024, 3, 31),
              focusedDate: _selectedDate,
              onDateChange: (selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
