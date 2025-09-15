// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction _model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionsModelAdapter extends TypeAdapter<TransactionsModel> {
  @override
  final int typeId = 3;

  @override
  TransactionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionsModel(
      id: fields[0] as String?,
      name: fields[1] as String,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
      type: fields[4] as CategoryType,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
