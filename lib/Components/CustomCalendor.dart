import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendor extends StatefulWidget {
  final BirthdayModel? birthdayItem;

  const CustomCalendor({required this.birthdayItem, super.key});

  @override
  State<CustomCalendor> createState() => _CustomCalendorState();
}

class _CustomCalendorState extends State<CustomCalendor> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd MMM, yyyy').format(widget.birthdayItem!.date);
    String formattedDateText =
        DateFormat('MMM DD, yyyy').format(widget.birthdayItem!.date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF21212114),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF152C8D),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  formattedDateText,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              controlsTextStyle: TextStyle(fontSize: 12),
              lastDate: DateTime.now(),
              calendarType: CalendarDatePicker2Type.single,
            ),
            value: [widget.birthdayItem?.date],
            onValueChanged: (dates) {
              // Prevent changes to the date
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
