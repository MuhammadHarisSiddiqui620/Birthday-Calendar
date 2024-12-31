import 'package:birthday_calendor/Screens/BaseScreen.dart';
import 'package:birthday_calendor/Screens/MainScreen.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Username extends StatelessWidget {
  const Username({super.key});

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.svg';

    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
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
            padding: EdgeInsets.symmetric(vertical: 148, horizontal: 30),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter your name',
                    textAlign: TextAlign.start,
                    style: secondaryTextStyle,
                  ),
                  TextField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              20), //Change this value to custom as you like
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  ElevatedButton(
                    style: primaryButton,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BaseScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Color(0xFFF3F3F3),
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w100), // ensure text color is white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
