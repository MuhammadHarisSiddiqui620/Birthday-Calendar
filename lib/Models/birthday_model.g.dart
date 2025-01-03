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
      name: fields[0] as String,
      date: fields[1] as String,
      alarmDay: fields[2] as String,
      giftList: (fields[3] as List).cast<String>(),
      image: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BirthdayModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.alarmDay)
      ..writeByte(3)
      ..write(obj.giftList)
      ..writeByte(4)
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
