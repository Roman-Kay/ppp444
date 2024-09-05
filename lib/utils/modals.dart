class ClothesItem {
  final String imageName;
  final String name;
  final String category;

  ClothesItem({
    required this.imageName,
    required this.name,
    required this.category,
  });
}

class LookItem {
  final String name;
  final List<ClothesItem> clothesItem;

  LookItem({
    required this.name,
    required this.clothesItem,
  });
}

class FolderItem {
  final String name;
  final List<LookItem> lookstems;

  FolderItem({
    required this.name,
    required this.lookstems,
  });
}
