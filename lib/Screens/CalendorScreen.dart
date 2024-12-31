import 'package:flutter/material.dart';

class CalendorScreen extends StatefulWidget {
  const CalendorScreen({super.key});

  @override
  State<CalendorScreen> createState() => _CalendorScreenState();
}

class _CalendorScreenState extends State<CalendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFBAC8FF),
        ),
      ),
    );
  }
}
