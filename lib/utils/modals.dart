import 'package:hive/hive.dart';

part 'modals.g.dart';

@HiveType(typeId: 1)
class ClothesItem {
  @HiveField(0)
  String imageBase64;
  @HiveField(1)
  String name;
  @HiveField(2)
  String category;

  ClothesItem({
    required this.imageBase64,
    required this.name,
    required this.category,
  });
}

@HiveType(typeId: 2)
class CategoryItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<String> subNames;

  CategoryItem({
    required this.name,
    required this.subNames,
  });
}

@HiveType(typeId: 3)
class LookItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<ClothesItem> clothesItem;

  LookItem({
    required this.name,
    required this.clothesItem,
  });
}

@HiveType(typeId: 4)
class FolderItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<LookItem> lookstems;

  FolderItem({
    required this.name,
    required this.lookstems,
  });
}
