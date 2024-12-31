import 'package:flutter/material.dart';

class CreateBirthdayScreen extends StatefulWidget {
  const CreateBirthdayScreen({super.key});

  @override
  State<CreateBirthdayScreen> createState() => _CreateBirthdayScreenState();
}

class _CreateBirthdayScreenState extends State<CreateBirthdayScreen> {
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
