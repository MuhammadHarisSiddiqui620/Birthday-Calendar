import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:birthday_calendor/screens/Username.dart';
import 'package:birthday_calendor/screens/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Simulate splash duration
    final box = Hive.box<BirthdayModel>('birthday-db');

    // Retrieve the instance of BirthdayModel using the key 'DeviceName'
    final birthdayModel =
        box.get('DeviceName'); // This is a BirthdayModel instance or null

    if (birthdayModel != null && birthdayModel.DeviceName.isNotEmpty) {
      // Navigate to BaseScreen if DeviceName exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BaseScreen(deviceName: birthdayModel.DeviceName),
        ),
      );
    } else {
      // Navigate to Username screen if no DeviceName is saved
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Username(),
        ),
      );
    }

    print("deviceName= ${birthdayModel?.DeviceName ?? 'No DeviceName'}");
  }

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.svg';
    const String iconAsset = 'assets/ic_gift.svg';

    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Center(
            child: SvgPicture.asset(
              backgroundAsset,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Centered Icon
                SvgPicture.asset(
                  iconAsset,
                  width: 120,
                  height: 120,
                ),
              ],
            ),
          ),
          // Bottom Text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              'Birthday Calendar',
              textAlign: TextAlign.center,
              style: primaryTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
