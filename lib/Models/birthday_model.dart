import 'package:hive/hive.dart';

part 'birthday_model.g.dart';

@HiveType(typeId: 1)
class BirthdayModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String date;

  @HiveField(2)
  String alarmDay;

  @HiveField(3)
  List<String> giftList;

  @HiveField(4)
  String image;

  BirthdayModel({
    required this.name,
    required this.date,
    required this.alarmDay,
    required this.giftList,
    required this.image,
  });
}
