import 'dart:io';

import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/Screens/BaseScreen.dart';
import 'package:birthday_calendor/Screens/CreateBirthdayScreen.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BirthdayScreen extends StatefulWidget {
  final BirthdayModel? birthdayItem;

  const BirthdayScreen({super.key, required this.birthdayItem});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  bool isWritingGift = false;
  List<TextEditingController> giftControllers = [];
  List<TextEditingController> costControllers = [];

  @override
  void initState() {
    super.initState();

    // Initialize controllers for each gift
    for (int i = 0; i < 3; i++) {
      giftControllers.add(TextEditingController());
      costControllers.add(TextEditingController());

      // Pre-fill controllers if data exists
      if (widget.birthdayItem!.giftList.length > i) {
        giftControllers[i].text = widget.birthdayItem!.giftList[i];
        costControllers[i].text = widget.birthdayItem!.giftCost[i].toString();
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    for (var controller in giftControllers) {
      controller.dispose();
    }
    for (var controller in costControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String calculateDaysUntilNextBirthday(DateTime birthday) {
    final today = DateTime.now();
    final thisYearBirthday = DateTime(today.year, birthday.month, birthday.day);

    // If the birthday this year is in the past, calculate for next year
    final nextBirthday = thisYearBirthday.isBefore(today)
        ? DateTime(today.year + 1, birthday.month, birthday.day)
        : thisYearBirthday;

    final difference = nextBirthday.difference(today).inDays;

    return "$difference";
  }

  String calculateYearUntilNextBirthday(DateTime birthday) {
    final today = DateTime.now();

    // Calculate the current age
    int currentAge = today.year - birthday.year;

    final thisYearBirthday = DateTime(today.year, birthday.month, birthday.day);

    // If the birthday this year is in the past, calculate for next year
    final nextBirthday = thisYearBirthday.isBefore(today)
        ? DateTime(today.year + 1, birthday.month, birthday.day)
        : thisYearBirthday;

    final difference = nextBirthday.difference(today).inDays;

    final thisYearBirthdays =
        DateTime(today.year, birthday.month, birthday.day);

    // If the birthday this year is in the past, calculate for next year
    final nextBirthdays = thisYearBirthdays.isBefore(today)
        ? DateTime(today.year + 1, birthday.month, birthday.day)
        : thisYearBirthdays;

    final differences = nextBirthdays.difference(today).inDays;

    print('BirthdayScreen birthday day ${birthday.day}');
    print('BirthdayScreen birthday month ${birthday.month}');
    print('BirthdayScreen birthday year ${birthday.year}');
    print('BirthdayScreen today day ${today.day}');
    print('BirthdayScreen today month ${today.month}');
    print('BirthdayScreen today year ${today.year}');
    print('BirthdayScreen currentAge ${currentAge}');
    print('BirthdayScreen difference ${difference}');
    print('BirthdayScreen difference.inDays ${difference}');

    if (!(currentAge < 1)) {
      return "$currentAge years";
    } else if (!(currentAge < 1) && !(difference < 1)) {
      return "$difference months";
    } else if (differences < 30) {
      return "${differences} days";
    }
    return "No days";

/*    if (difference.inDays < 30) {
      return "${difference.inDays} days";
    } else if (difference.inDays < 365) {
      int monthsUntilNextMilestone = (difference.inDays / 30).floor();
      return "$monthsUntilNextMilestone months";
    } else {
      int yearsUntilNextMilestone = difference.inDays ~/ 365;
      return "$yearsUntilNextMilestone years";
    }*/
  }

  Row _buildGiftRow({
    required int index,
    required TextEditingController giftController,
    required TextEditingController costController,
  }) {
    bool isGiftFilled = index < widget.birthdayItem!.giftList.length &&
        widget.birthdayItem!.giftList[index].isNotEmpty &&
        widget.birthdayItem!.giftCost[index] > 0;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFF5F5F7),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text("${index + 1}"),
        ),
        SizedBox(width: 10),
        Expanded(
          child: isGiftFilled
              ? Text(
                  "${widget.birthdayItem!.giftList[index]} - \$${widget.birthdayItem!.giftCost[index]}",
                  style: birthdaySecondaryText,
                )
              : isWritingGift
                  ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: giftController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Gift',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: costController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Cost',
                            ),
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isWritingGift = true;
                        });
                      },
                      child: Text("Write...", style: birthdaySecondaryText),
                    ),
        ),
      ],
    );
  }

  void _saveGifts() {
    List<String> giftList = [];
    List<int> giftCost = [];

    for (int i = 0; i < giftControllers.length; i++) {
      if (giftControllers[i].text.trim().isNotEmpty &&
          costControllers[i].text.trim().isNotEmpty) {
        giftList.add(giftControllers[i].text.trim());
        giftCost.add(int.parse(costControllers[i].text.trim()));
      } else if (giftControllers[i].text.trim().isEmpty !=
          costControllers[i].text.trim().isEmpty) {
        /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Fill both Gift and Cost fields for Row ${i + 1}.")),
        );*/
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BaseScreen(),
        ),
      );
    }

    setState(() {
      widget.birthdayItem!.giftList = giftList;
      widget.birthdayItem!.giftCost = giftCost;
    });

    try {
      widget.birthdayItem!.save(); // Save to Hive or database
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gifts saved successfully!")),
      );*/
    } catch (e) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save gifts: $e")),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy').format(widget.birthdayItem!.date);

    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/splashscreen.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.more_horiz,
                            color: Color(0xFF141522),
                            size: 35,
                          ),
                          onTap: () {
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    ),*/
                    SizedBox(
                      height: 25,
                    ),
                    if (widget.birthdayItem?.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          File(widget.birthdayItem!.image),
                          width: double.infinity,
                          height: 148,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(height: 17),
                    Text(
                      widget.birthdayItem!.birthdayName,
                      style: birthdayFirstText,
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                          color: Color(0xFF54577A),
                          fontSize: 12,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey[300]),
                    Text("Gift list", style: birthdayFirstText),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Birthday",
                          style: birthdayFirstText,
                        ),
                        Text(
                          "${calculateDaysUntilNextBirthday(widget.birthdayItem!.date)} days",
                          style: TextStyle(
                              color: Color(0xFF546FFF),
                              fontSize: 16,
                              fontFamily: 'PlusJakartaSans',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Slider(
                      value: double.parse(calculateDaysUntilNextBirthday(
                          widget.birthdayItem!.date)),
                      max: 364,
                      thumbColor: Color(0xFF210D5D),
                      activeColor: Color(0xFF152C8D),
                      inactiveColor: Color(0xFFBAC8FF),
                      onChanged: (value) {},
                    ),
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${calculateYearUntilNextBirthday(widget.birthdayItem!.date)}",
                          style: TextStyle(
                              color: Color(0xFF141522),
                              fontSize: 16,
                              fontFamily: 'PlusJakartaSans',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 21),
                        child: _buildGiftRow(
                          index: i,
                          giftController: giftControllers[i],
                          costController: costControllers[i],
                        ),
                      ),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      style: primaryButton,
                      onPressed: _saveGifts,
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
          // Background SVG
        ],
      ),
    );
  }
}
