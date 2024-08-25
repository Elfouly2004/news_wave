// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fillprofile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FillprofileModelAdapter extends TypeAdapter<FillprofileModel> {
  @override
  final int typeId = 1;

  @override
  FillprofileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FillprofileModel(
      pic: fields[0] as String?,
      Fullname: fields[1] as String?,
      Email: fields[2] as String?,
      phonenumber: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FillprofileModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.pic)
      ..writeByte(1)
      ..write(obj.Fullname)
      ..writeByte(2)
      ..write(obj.Email)
      ..writeByte(3)
      ..write(obj.phonenumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FillprofileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
