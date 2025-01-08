import 'dart:io';

import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BirthdayScreen extends StatefulWidget {
  final BirthdayModel? birthdayItem;

  const BirthdayScreen({super.key, required this.birthdayItem});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.svg';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background SVG
          SvgPicture.asset(
            backgroundAsset,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 77, horizontal: 35),
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
                Text("data"),
                Text(
                  widget.birthdayItem!.date,
                  style: TextStyle(),
                ),

                Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
