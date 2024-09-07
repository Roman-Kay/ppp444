import 'package:hive/hive.dart';

part 'modals.g.dart';

class CategoryItem {
  final String name;
  final List<String> subNames;

  CategoryItem({
    required this.name,
    required this.subNames,
  });
}

@HiveType(typeId: 1)
class ClothesItem {
  @HiveField(0)
  String imageBase64;
  @HiveField(1)
  String name;
  @HiveField(2)
  String category;
  @HiveField(3)
  List<String>? looks;

  ClothesItem({
    required this.imageBase64,
    required this.name,
    required this.category,
    this.looks,
  });
}

@HiveType(typeId: 2)
class LookItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<ClothesItem> clothesItem;
  @HiveField(2)
  List<String>? folders;

  LookItem({
    required this.name,
    required this.clothesItem,
    this.folders,
  });
}

@HiveType(typeId: 3)
class FolderItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<LookItem> looksItems;

  FolderItem({
    required this.name,
    required this.looksItems,
  });
}
