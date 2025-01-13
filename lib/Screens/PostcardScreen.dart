import 'package:birthday_calendor/constants.dart';
import 'package:flutter/material.dart';

class PostcardScreen extends StatefulWidget {
  const PostcardScreen({super.key});

  @override
  State<PostcardScreen> createState() => _PostcardScreenState();
}

class _PostcardScreenState extends State<PostcardScreen> {
  String? selectedImage; // State variable to track the selected image
  final TextEditingController nameController = TextEditingController();
  String inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color(0xFFBAC8FF),
          ),
          ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (inputText.isEmpty)
                      const Text(
                        "Birthday",
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF141522),
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (inputText.isEmpty) const SizedBox(height: 8),
                    if (inputText.isEmpty)
                      const Text(
                        "Choose your congratulations!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF54577A),
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 17),
                    if (selectedImage == null)
                      Wrap(
                        spacing: 10, // Horizontal spacing between cards
                        runSpacing: 40, // Vertical spacing between rows
                        children: List.generate(6, (index) {
                          String imagePath =
                              'images/post_card_${(index % 6) + 1}.png';
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage =
                                    imagePath; // Update selected image
                              });
                            },
                            child: Image.asset(
                              imagePath,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: Image.asset(
                              selectedImage!,
                              width: 347, // Larger width
                              height: 214, // Larger height
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 26),
                          if (inputText.isEmpty) ...[
                            TextField(
                              minLines: 5,
                              maxLines: null,
                              controller: nameController,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 20, 20, 20),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                hintText: '...or write your own text',
                                hintStyle: postCardInputText,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, 52),
                                backgroundColor: Color(0xFF152C8D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (nameController.text.isNotEmpty) {
                                    inputText = nameController.text;
                                  }
                                });
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ] else
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFF152C8D),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      inputText,
                                      style: TextStyle(
                                        color: Color(0xFFF3F3F3),
                                        fontSize: 16,
                                        fontFamily: 'PlusJakartaSans',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(48.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.file_download,
                                      size: 36,
                                    ),
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
