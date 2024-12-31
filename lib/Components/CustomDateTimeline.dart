import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimeline extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime focusedDate;
  final ValueChanged<DateTime> onDateChange;

  const CustomDateTimeline({
    required this.firstDate,
    required this.lastDate,
    required this.focusedDate,
    required this.onDateChange,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDateTimeline> createState() => _CustomDateTimelineState();
}

class _CustomDateTimelineState extends State<CustomDateTimeline> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.focusedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.lastDate.difference(widget.firstDate).inDays + 1,
        itemBuilder: (context, index) {
          DateTime date = widget.firstDate.add(Duration(days: index));
          String dayName = DateFormat('EEE').format(date); // Get day name
          bool isSelected = date == _selectedDate;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateChange(date);
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
