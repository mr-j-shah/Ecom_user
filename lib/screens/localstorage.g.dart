// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localstorage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class cartproductAdapter extends TypeAdapter<cartproduct> {
  @override
  final int typeId = 0;

  @override
  cartproduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return cartproduct()
      ..name = fields[0] as String
      ..description = fields[1] as String
      ..imagelink = fields[2] as String
      ..category = fields[3] as String
      ..quantity = fields[4] as int
      ..price = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, cartproduct obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagelink)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is cartproductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
