import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/Screens/BirthdayScreen.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomMiniCalendor extends StatefulWidget {
  final BirthdayModel? birthdayItem;

  const CustomMiniCalendor({
    required this.birthdayItem,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomMiniCalendor> createState() => _CustomMiniCalendorState();
}

class _CustomMiniCalendorState extends State<CustomMiniCalendor> {
  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd MMM, yyyy').format(widget.birthdayItem!.date);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Color(0xFF5F33E1),
              ),
              SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.birthdayItem!.birthdayName,
                    style: TextStyle(
                        color: Color(0xFF6E6A7C),
                        fontSize: 12,
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    formattedDate,
                    style: miniCalendorDate,
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: Color(0xFF24252C),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BirthdayScreen(birthdayItem: widget.birthdayItem),
          ),
        );
      },
    );
  }
}
