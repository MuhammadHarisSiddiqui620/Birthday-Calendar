import 'dart:io';

import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/Screens/BirthdayScreen.dart';
import 'package:birthday_calendor/Screens/PostcardScreen.dart';
import 'package:birthday_calendor/constants.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CreateBirthdayScreen extends StatefulWidget {
  const CreateBirthdayScreen({super.key});

  @override
  State<CreateBirthdayScreen> createState() => _CreateBirthdayScreenState();
}

class _CreateBirthdayScreenState extends State<CreateBirthdayScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  final hiveBox = Hive.box<BirthdayModel>('birthday-db');
  late File savedImage;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Convert the picked file into a File object
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        // Save the image to Hive
        final appDir = await getApplicationDocumentsDirectory();

        // Save the file to app's directory
        final imagePath =
            '${appDir.path}/${DateTime.now().toIso8601String()}.png';
        savedImage = await _imageFile!.copy(imagePath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.svg';
    final TextEditingController nameController = TextEditingController();
    const String iconAsset = 'assets/ic_upload.svg';
    List<DateTime?> value = const [];

    return Stack(
      children: [
        // Background SVG
        SvgPicture.asset(
          backgroundAsset,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        // Foreground Content
        ListView(
          padding: EdgeInsets.only(top: 148, left: 30, right: 30, bottom: 30),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Birthday',
                  textAlign: TextAlign.start,
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 54),
                GestureDetector(
                  onTap: _pickImage,
                  child: _imageFile == null
                      ? SvgPicture.asset(
                          iconAsset,
                          width: 100,
                          height: 100,
                        )
                      : Image.file(
                          _imageFile!,
                          width: 100,
                          height: 100,
                          fit:
                              BoxFit.cover, // Optional: Adjust the image to fit
                        ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    hintText: 'name',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      lastDate: DateTime.now(),
                      calendarType: CalendarDatePicker2Type.single,
                    ),
                    value: value,
                    onValueChanged: (dates) => value = dates,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: primaryButton,
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final selectedDate = value.isNotEmpty ? value.first : null;

                    if (name.isNotEmpty && selectedDate != null) {
                      // Create a new BirthdayModel instance
                      final newBirthday = BirthdayModel(
                        DeviceName: "",
                        birthdayName: name,
                        date: selectedDate.toString(),
                        giftList: [], // Add gift list if applicable
                        image: savedImage.path,
                      );

                      // Save to Hive
                      await hiveBox.add(newBirthday);

                      // Navigate to the next screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BirthdayScreen(birthdayItem: newBirthday),
                        ),
                      );
                      for (var i = 0; i < hiveBox.length; i++) {
                        var birthdayModel = hiveBox.getAt(i);
                        print("values: ${birthdayModel?.birthdayName}, "
                            "${birthdayModel?.image}, "
                            "${birthdayModel?.date}");
                      }
                    } else {
                      // Show error if name or date is missing
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please provide a name and date!')),
                      );
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xFFF3F3F3),
                      fontSize: 16,
                      fontWeight: FontWeight.w500, // ensure text color is white
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
