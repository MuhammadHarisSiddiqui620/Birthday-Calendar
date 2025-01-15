import 'package:birthday_calendor/Components/CustomCalendor.dart';
import 'package:birthday_calendor/Components/CustomMiniCalendor.dart';
import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalendorScreen extends StatefulWidget {
  const CalendorScreen({super.key});

  @override
  State<CalendorScreen> createState() => _CalendorScreenState();
}

class _CalendorScreenState extends State<CalendorScreen> {
  final hiveBox = Hive.box<BirthdayModel>('birthday-db');
  late List<BirthdayModel?> searchBirthdayItems;
  final Map<int, bool> calendarToggleStates =
      {}; // Map to store toggle states for each calendar

  @override
  void initState() {
    super.initState();
    searchBirthdayItems = [];
    for (var i = 0; i < hiveBox.length; i++) {
      if (hiveBox.getAt(i)?.birthdayName != "") {
        searchBirthdayItems.add(hiveBox.getAt(i));
        calendarToggleStates[i] =
            false; // Initialize all to false (show MiniCalendor initially)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color(0xFFBAC8FF),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: searchBirthdayItems.isNotEmpty
                  ? searchBirthdayItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      BirthdayModel? birthday = entry.value;
                      if (birthday == null) return const SizedBox.shrink();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              calendarToggleStates[index] =
                                  !(calendarToggleStates[index] ?? false);
                            });
                          },
                          child: calendarToggleStates[index] ?? false
                              ? CustomCalendor(birthdayItem: birthday)
                              : CustomMiniCalendor(birthdayItem: birthday),
                        ),
                      );
                    }).toList()
                  : [
                      const Center(
                        child: Text(
                          "No birthdays available",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
