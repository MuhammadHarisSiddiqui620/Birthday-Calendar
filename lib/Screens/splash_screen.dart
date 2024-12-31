import 'package:birthday_calendor/constants.dart';
import 'package:birthday_calendor/screens/Username.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main page after 2 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Username(),
        ),
      );
    });
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
