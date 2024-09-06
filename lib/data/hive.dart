import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/utils/modals.dart';

late Box box;

getkey(value) {
  if (value.runtimeType == ClothesItem) {
    return 'listOfClothesItems';
  }
  if (value.runtimeType == LookItem) {
    return 'listOfClothesItems';
  }
  if (value.runtimeType == ClothesItem) {
    return 'listOfClothesItems';
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
    int index = helpList.indexOf(1);
    helpList[index] = value;
    box.put(key, helpList);
  }
}
