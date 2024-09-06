import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/utils/modals.dart';

late Box box;

enum HiveKeys { listOfClothesItems, listOfLooksItems, listOfFoldersItems }

// final ff = HiveKeys.listOfClothesItems;
getkey(value) {
  if (value.runtimeType == ClothesItem) {
    return 'listOfClothesItems';
  }
  if (value.runtimeType == LookItem) {
    return 'listOfLooksItems';
  }
  if (value.runtimeType == FolderItem) {
    return 'listOfFoldersItems';
  }
}

addToList(dynamic value) {
  dynamic key = getkey(value);
  List helpList = box.get(key) ?? [];
  helpList.add(value);
  box.put(key, helpList);
}

deleteItemFromList(dynamic value) {
  dynamic key = getkey(value);
  final response = box.get(key);
  if (response != null && response != []) {
    List helpList = response;
    helpList.removeWhere((element) => element == value);
    box.put(key, helpList);
  }
}

editItemInList(dynamic changeValue, dynamic value) {
  dynamic key = getkey(value);

  final response = box.get(key);
  if (response != null && response != []) {
    List helpList = response;
    int index = helpList.indexOf(changeValue);
    helpList[index] = value;
    box.put(key, helpList);
  }
}
