// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClothesItemAdapter extends TypeAdapter<ClothesItem> {
  @override
  final int typeId = 1;

  @override
  ClothesItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClothesItem(
      imageBase64: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as CategoryItem,
    );
  }

  @override
  void write(BinaryWriter writer, ClothesItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageBase64)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothesItemAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class CategoryItemAdapter extends TypeAdapter<CategoryItem> {
  @override
  final int typeId = 2;

  @override
  CategoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryItem(
      name: fields[0] as String,
      subNames: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subNames);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryItemAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class LookItemAdapter extends TypeAdapter<LookItem> {
  @override
  final int typeId = 3;

  @override
  LookItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LookItem(
      name: fields[0] as String,
      clothesItem: (fields[1] as List).cast<ClothesItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, LookItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.clothesItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LookItemAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class FolderItemAdapter extends TypeAdapter<FolderItem> {
  @override
  final int typeId = 4;

  @override
  FolderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderItem(
      name: fields[0] as String,
      lookstems: (fields[1] as List).cast<LookItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, FolderItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lookstems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderItemAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
