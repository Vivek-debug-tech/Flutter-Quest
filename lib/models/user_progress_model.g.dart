// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgressAdapter extends TypeAdapter<UserProgress> {
  @override
  final int typeId = 0;

  @override
  UserProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgress(
      totalXP: fields[0] as int,
      currentLevel: fields[1] as int,
      unlockedWorlds: (fields[2] as List?)?.cast<String>(),
      completedLevels: (fields[3] as List?)?.cast<String>(),
      earnedBadges: (fields[4] as List?)?.cast<String>(),
      currentStreak: fields[5] as int,
      lastLoginDate: fields[6] as DateTime?,
      levelProgressMap: (fields[7] as Map?)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProgress obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.totalXP)
      ..writeByte(1)
      ..write(obj.currentLevel)
      ..writeByte(2)
      ..write(obj.unlockedWorlds)
      ..writeByte(3)
      ..write(obj.completedLevels)
      ..writeByte(4)
      ..write(obj.earnedBadges)
      ..writeByte(5)
      ..write(obj.currentStreak)
      ..writeByte(6)
      ..write(obj.lastLoginDate)
      ..writeByte(7)
      ..write(obj.levelProgressMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
