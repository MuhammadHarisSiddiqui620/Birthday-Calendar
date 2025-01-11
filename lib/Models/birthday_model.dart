import 'dart:ffi';

import 'package:hive/hive.dart';

part 'birthday_model.g.dart';

@HiveType(typeId: 1)
class BirthdayModel extends HiveObject {
  @HiveField(0)
  String DeviceName;

  @HiveField(1)
  String birthdayName;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<String> giftList;

  @HiveField(4)
  List<int> giftCost;

  @HiveField(5)
  String image;

  BirthdayModel({
    required this.DeviceName,
    required this.birthdayName,
    required this.date,
    required this.giftList,
    required this.giftCost,
    required this.image,
  });
}
