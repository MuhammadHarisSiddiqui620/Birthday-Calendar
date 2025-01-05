import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final hiveBox = Hive.box<BirthdayModel>('birthday-db');

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.svg';
    final TextEditingController nameController = TextEditingController();

    return Stack(
      children: [
        SvgPicture.asset(
          backgroundAsset,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        ListView(
          padding: EdgeInsets.only(top: 148, left: 30, right: 30, bottom: 30),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search',
                  textAlign: TextAlign.start,
                  style: secondaryTextStyle,
                ),
                SizedBox(
                  height: 238,
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
                    hintText: 'Name',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search history',
                      textAlign: TextAlign.start,
                      style: thirdlyTextStyle,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Color(0xFFD97474),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
