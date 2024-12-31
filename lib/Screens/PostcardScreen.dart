import 'package:flutter/material.dart';

class PostcardScreen extends StatefulWidget {
  const PostcardScreen({super.key});

  @override
  State<PostcardScreen> createState() => _PostcardScreenState();
}

class _PostcardScreenState extends State<PostcardScreen> {
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
