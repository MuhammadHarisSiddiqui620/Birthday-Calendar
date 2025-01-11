// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthday_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BirthdayModelAdapter extends TypeAdapter<BirthdayModel> {
  @override
  final int typeId = 1;

  @override
  BirthdayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BirthdayModel(
      DeviceName: fields[0] as String,
      birthdayName: fields[1] as String,
      date: fields[2] as DateTime,
      giftList: (fields[3] as List).cast<String>(),
      giftCost: (fields[4] as List).cast<int>(),
      image: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BirthdayModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.DeviceName)
      ..writeByte(1)
      ..write(obj.birthdayName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.giftList)
      ..writeByte(4)
      ..write(obj.giftCost)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirthdayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
