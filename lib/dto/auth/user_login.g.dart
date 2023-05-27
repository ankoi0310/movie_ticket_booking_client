// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLoginResponseAdapter extends TypeAdapter<UserLoginResponse> {
  @override
  final int typeId = 0;

  @override
  UserLoginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLoginResponse(
      id: fields[0] as int,
      email: fields[1] as String,
      token: fields[2] as String,
      avatar: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLoginResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
