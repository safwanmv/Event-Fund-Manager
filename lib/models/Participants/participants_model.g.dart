// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participants_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticipantsModelAdapter extends TypeAdapter<ParticipantsModel> {
  @override
  final int typeId = 6;

  @override
  ParticipantsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParticipantsModel(
      id: fields[1] as String?,
      participantId: fields[2] as String,
      eventId: fields[3] as String,
      amountPaid: fields[4] as double,
      joinedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ParticipantsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.participantId)
      ..writeByte(3)
      ..write(obj.eventId)
      ..writeByte(4)
      ..write(obj.amountPaid)
      ..writeByte(5)
      ..write(obj.joinedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticipantsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
