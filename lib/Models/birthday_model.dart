import 'package:hive/hive.dart';

part 'birthday_model.g.dart';

@HiveType(typeId: 1)
class BirthdayModel extends HiveObject {
  @HiveField(0)
  String DeviceName;

  @HiveField(1)
  String birthdayName;

  @HiveField(2)
  String date;

  @HiveField(3)
  List<String> giftList;

  @HiveField(4)
  String image;

  BirthdayModel({
    required this.DeviceName,
    required this.birthdayName,
    required this.date,
    required this.giftList,
    required this.image,
  });
}
