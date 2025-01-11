import 'dart:io';

import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BirthdayScreen extends StatefulWidget {
  final BirthdayModel? birthdayItem;

  const BirthdayScreen({super.key, required this.birthdayItem});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  double _currentSliderValue = 100;
  String backgroundAsset = 'assets/splashscreen.svg';

  bool isWritingGift = false; // State variable to toggle view
  TextEditingController giftController = TextEditingController();
  TextEditingController secondgiftController = TextEditingController();
  TextEditingController thirdgiftController = TextEditingController();

  TextEditingController costController = TextEditingController();
  TextEditingController secondCostController = TextEditingController();
  TextEditingController thirdCostController = TextEditingController();

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
    int currentAge = today.year - birthday.year;

    // If the birthday hasn't occurred this year yet, subtract 1 from the current age
    if (DateTime(today.year, birthday.month, birthday.day).isAfter(today)) {
      currentAge--;
    }

    // Calculate the next milestone birthday (e.g., 30, 40, etc.)
    int nextMilestoneAge = ((currentAge ~/ 10) + 1) * 10;

    // Calculate the year when the next milestone birthday will occur
    int milestoneYear = birthday.year + nextMilestoneAge;

    // Calculate the difference in years
    int yearsUntilNextMilestone = milestoneYear - today.year;

    return "$yearsUntilNextMilestone years";
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy').format(widget.birthdayItem!.date);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(
            backgroundAsset,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Foreground Content
          ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 77, horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Image
                    if (widget.birthdayItem?.image != null)
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10.0), // Apply border radius
                        child: Image.file(
                          File(widget.birthdayItem!.image),
                          width: double.infinity,
                          height: 148,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(
                      height: 17,
                    ),
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
                    SizedBox(
                      height: 20,
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
                    SizedBox(
                      height: 35,
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 0.005,
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Gift list",
                      style: birthdayFirstText,
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF5F5F7),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text("1"),
                        ),
                        SizedBox(width: 10),
                        isWritingGift
                            ? Expanded(
                                child: Row(
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
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWritingGift =
                                        true; // Toggle to show TextField
                                  });
                                },
                                child: Text("Write...",
                                    style: birthdaySecondaryText),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF5F5F7),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text("2"),
                        ),
                        SizedBox(width: 10),
                        isWritingGift
                            ? Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: secondgiftController,
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
                                        controller: secondCostController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Cost',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.birthdayItem!.giftList.isNotEmpty)
                                    for (int i = 0;
                                        i <
                                            widget
                                                .birthdayItem!.giftList.length;
                                        i++)
                                      Text(
                                        "${widget.birthdayItem!.giftList[i]} - \$${widget.birthdayItem!.giftCost[i]}",
                                        style: birthdaySecondaryText,
                                      ),
                                  if (widget.birthdayItem!.giftList.isEmpty)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isWritingGift = true;
                                        });
                                      },
                                      child: Text("Write...",
                                          style: birthdaySecondaryText),
                                    ),
                                ],
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF5F5F7),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text("3"),
                        ),
                        SizedBox(width: 10),
                        isWritingGift
                            ? Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: thirdgiftController,
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
                                        controller: thirdCostController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Cost',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWritingGift =
                                        true; // Toggle to show TextField
                                  });
                                },
                                child: Text("Write...",
                                    style: birthdaySecondaryText),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: primaryButton,
                      onPressed: () async {
                        List<String> giftList = [];
                        List<int> giftCost = [];

                        // Validate and collect gifts and costs
                        if (giftController.text.trim().isNotEmpty &&
                            costController.text.trim().isNotEmpty) {
                          try {
                            giftList.add(giftController.text.trim());
                            giftCost.add(int.parse(costController.text.trim()));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Invalid cost input. Please enter a valid number.")),
                            );
                            return;
                          }
                        }

                        if (secondgiftController.text.trim().isNotEmpty &&
                            secondCostController.text.trim().isNotEmpty) {
                          try {
                            giftList.add(secondgiftController.text.trim());
                            giftCost.add(
                                int.parse(secondCostController.text.trim()));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Invalid cost input. Please enter a valid number.")),
                            );
                            return;
                          }
                        }

                        if (thirdgiftController.text.trim().isNotEmpty &&
                            thirdCostController.text.trim().isNotEmpty) {
                          try {
                            giftList.add(thirdgiftController.text.trim());
                            giftCost.add(
                                int.parse(thirdCostController.text.trim()));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Invalid cost input. Please enter a valid number.")),
                            );
                            return;
                          }
                        }

                        // Update the birthday item
                        if (widget.birthdayItem != null) {
                          setState(() {
                            widget.birthdayItem!.giftList = giftList;
                            widget.birthdayItem!.giftCost = giftCost;
                            isWritingGift =
                                false; // Switch back to display mode
                          });
                        }

                        // Feedback message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Gift list updated successfully.")),
                        );
                      },
                      child: Text("Save"),
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
