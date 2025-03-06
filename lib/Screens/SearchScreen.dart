import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/Screens/BirthdayScreen.dart';
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
  late List<BirthdayModel?> searchBirthdayItems;
  late List<BirthdayModel?> filteredBirthdayItems;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBirthdayItems = [];
    filteredBirthdayItems = [];
    for (var i = 0; i < hiveBox.length; i++) {
      if (hiveBox.getAt(i)?.birthdayName != "") {
        searchBirthdayItems.add(hiveBox.getAt(i));
      }
    }
    filteredBirthdayItems.addAll(searchBirthdayItems);

    nameController.addListener(() {
      _filterBirthdayItems();
    });
  }

  void _filterBirthdayItems() {
    String query = nameController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredBirthdayItems = List.from(searchBirthdayItems);
      } else {
        filteredBirthdayItems = searchBirthdayItems
            .where((item) => item!.birthdayName.toLowerCase().startsWith(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/background_wallpaper.svg",
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                      child: Visibility(
                        visible: false,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Color(0xFFD97474),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Container(
                    child: Wrap(
                      children: [
                        for (var item in filteredBirthdayItems)
                          GestureDetector(
                            child: SearchItems(birthdayitem: item),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BirthdayScreen(birthdayItem: item),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 63,
                ),
                ElevatedButton(
                  style: primaryButton,
                  onPressed: () async {
                    /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BirthdayScreen(: ),
                        ),
                      );*/
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                        color: Color(0xFFF3F3F3),
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w100), // ensure text color is white
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

class SearchItems extends StatelessWidget {
  final BirthdayModel? birthdayitem;
  const SearchItems({super.key, required this.birthdayitem});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              birthdayitem!.birthdayName,
              textAlign: TextAlign.start,
              style: searchText,
            ),
          ),
        ));
  }
}
