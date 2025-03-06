import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/Screens/BaseScreen.dart';
import 'package:birthday_calendor/Screens/MainScreen.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Username extends StatelessWidget {
  const Username({super.key});

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/background_wallpaper.svg';

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
                    controller: nameController,
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
                    onPressed: () async {
                      final name = nameController.text.trim();
                      if (name.isNotEmpty) {
                        final box = Hive.box<BirthdayModel>('birthday-db');
                        // Create a BirthdayModel instance
                        final birthdayModel = BirthdayModel(
                          DeviceName: name, // Assign the name here
                          birthdayName:
                              '', // Add default or user-provided values
                          date: DateTime(
                              0), // Add default or user-provided values
                          giftList: [], // Add default or user-provided values
                          giftCost: [0],
                          image: '', // Add default or user-provided values
                        );

                        // Save the BirthdayModel instance in the box
                        await box.put(
                            'DeviceName', birthdayModel); // Save DeviceName
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BaseScreen(deviceName: name),
                          ),
                        );
                      }
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
