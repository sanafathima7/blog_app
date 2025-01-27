// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class postedQuestionAdapter extends TypeAdapter<postedQuestion> {
  @override
  final int typeId = 1;

  @override
  postedQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return postedQuestion(
      content: fields[0] as String,
      title: fields[1] as String,
      authId: fields[2] as int,
      answer: fields[3] as String,
      isPublished: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, postedQuestion obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authId)
      ..writeByte(3)
      ..write(obj.answer)
      ..writeByte(4)
      ..write(obj.isPublished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is postedQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
