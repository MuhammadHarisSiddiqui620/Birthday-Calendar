import 'package:birthday_calendor/Components/CustomMiniCalendor.dart';
import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainScreen extends StatefulWidget {
  final String deviceName;
  const MainScreen({super.key, required this.deviceName});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final hiveBox = Hive.box<BirthdayModel>('birthday-db');
  late List<BirthdayModel?> searchBirthdayItems;
  DateTime _selectedDate = DateTime(2025, 6, 15); // Initial focused date

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBirthdayItems = [];
    for (var i = 0; i < hiveBox.length; i++) {
      if (hiveBox.getAt(i)?.birthdayName != "") {
        searchBirthdayItems.add(hiveBox.getAt(i));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xFFBAC8FF),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: ListView(
          children: [
            Column(
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
                if (searchBirthdayItems.isNotEmpty)
                  ...searchBirthdayItems
                      .map(
                        (c) => Padding(
                          padding: const EdgeInsets.only(
                              bottom: 30.0), // Add spacing here
                          child: CustomMiniCalendor(birthdayItem: c),
                        ),
                      )
                      .toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
