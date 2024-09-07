import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/utils/modals.dart';

late Box box;

enum HiveKeys { listOfClothesItems, listOfLooksItems, listOfFoldersItems }

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

List<LookItem> getLooks() {
  final List listOfClothesItems = (box.get('listOfClothesItems') ?? []);
  List<LookItem> listOfLooksItems = [];
  // перебираем каждый элемент одежды
  for (ClothesItem cloth in listOfClothesItems) {
    // если у элемента одежды есть луки
    if (cloth.looks!.isNotEmpty) {
      // отправляем все луки на перебор
      for (var look in cloth.looks!) {
        // спомогательная переменная
        int? changedElementIndex;
        // если в листе из луков есть элемент с таким же названием как и лука одежды
        // тогда changedElementIndex становится index этого элемента
        if (listOfLooksItems.any((looksItemsNow) {
          bool check = (looksItemsNow.name == look);
          check == true ? changedElementIndex = listOfLooksItems.indexOf(looksItemsNow) : null;
          return check;
        })) {
          // тогда helpClothesItem вспомогатльная переменная для одежды которая уже лежит в луке
          List<ClothesItem> helpClothesItem = listOfLooksItems[changedElementIndex!].clothesItem;
          // добавляем к старой одежде в луке новую
          helpClothesItem.add(cloth);
          // изменяням наш LookItem
          listOfLooksItems[changedElementIndex!] = LookItem(
            name: look,
            clothesItem: helpClothesItem,
            folders: [],
          );
        } else {
          // если лука с таким названия еще нет, то создаем его
          listOfLooksItems.add(
            LookItem(
              name: look,
              clothesItem: [cloth],
              folders: [],
            ),
          );
        }
      }
    }
  }
  return listOfLooksItems;
}

List<FolderItem> getFolders() {
  final List<LookItem> listOfLooksItems = getLooks();
  List<FolderItem> listOfFolderItem = [];
  // перебираем каждый элемент одежды
  for (var look in listOfLooksItems) {
    // если у элемента одежды есть фолдеры
    if (look.folders!.isNotEmpty) {
      // отправляем все фолдеры на перебор
      for (var folder in look.folders!) {
        // спомогательная переменная
        int? changedElementIndex;
        // если в листе из фолдеров есть элемент с таким же названием как и фолдера лука
        // тогда changedElementIndex становится index этого элемента
        if (listOfFolderItem.any((foldersItemsNow) {
          bool check = (foldersItemsNow.name == folder);
          check == true ? changedElementIndex = listOfFolderItem.indexOf(foldersItemsNow) : null;
          return check;
        })) {
          // тогда helpClothesItem вспомогатльная переменная для лука которая уже лежит в фолдере
          List<LookItem> helpLookItem = listOfFolderItem[changedElementIndex!].looksItems;
          // добавляем к старой одежде в фолдера новую
          helpLookItem.add(look);
          // изменяням наш FolderItem
          listOfFolderItem[changedElementIndex!] = FolderItem(
            name: folder,
            looksItems: listOfLooksItems,
          );
        } else {
          // если лука с таким названия еще нет, то создаем его
          listOfFolderItem.add(
            FolderItem(
              name: folder,
              looksItems: [look],
            ),
          );
        }
      }
    }
  }
  return listOfFolderItem;
}
