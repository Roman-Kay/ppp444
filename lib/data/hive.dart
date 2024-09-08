import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/utils/modals.dart';
import 'dart:math';

late Box<ClothesItem> boxClothes;
late Box<LookItem> boxLooks;
late Box<FolderItem> boxFolders;

String generateKey() {
  int next(int min, int max) => min + Random().nextInt(max - min);
  String key = next(1000000, 9999999).toString();
  if (boxClothes.keys.toList().any((element) => element == key) &&
      boxLooks.keys.toList().any((element) => element == key) &&
      boxFolders.keys.toList().any((element) => element == key)) {
    return generateKey();
  } else {
    return key;
  }
}

deleteItemFromClothe(final int index) {
  ClothesItem? deleteValue = boxClothes.getAt(index);
  boxClothes.deleteAt(index);
  boxLooks.values.toList();
  deleteItemFromLook(deleteValue);
}

deleteItemFromLook(dynamic deleteValue) async {
  //  ИЗМЕНЕНИЕ ЛУКОВ (коментрирования схоже с Фолдорами)
  final List<LookItem> responseLooks = boxLooks.values.toList();
  Map<dynamic, LookItem> helpLooksMap = {};

  if (deleteValue.runtimeType == LookItem) {
    String key = boxLooks.keyAt(responseLooks.indexOf(deleteValue));
    await boxLooks.delete(key);
  } else {
    for (var lookItem in responseLooks) {
      String key = boxLooks.keyAt(responseLooks.indexOf(lookItem));
      List<ClothesItem> helpClothesList = [];

      for (var clothesItem in lookItem.clothesItem) {
        if (clothesItem != deleteValue) {
          helpClothesList.add(clothesItem);
        }
      }
      if (helpClothesList.isNotEmpty) {
        helpLooksMap[key] = LookItem(
          name: lookItem.name,
          clothesItem: helpClothesList,
        );
      }
    }
  }
  // удаляем все чтоб заново создать
  await boxLooks.clear();
  print(helpLooksMap.entries);
  boxLooks.putAll(helpLooksMap);
  deleteItemNameFolder(deleteValue);
}

deleteItemNameFolder(dynamic deleteValue) async {
  final List<FolderItem> responseFolders = boxFolders.values.toList();
  Map<dynamic, FolderItem> helpFoldersMap = {};
  // проверяем каждый фолдер
  for (FolderItem folderItem in responseFolders) {
    // создаем новый спомогательный лист луков внутри фолдера
    List<LookItem> helpLooksList = [];
    String key = boxFolders.keyAt(responseFolders.indexOf(folderItem));
    // в каждом фолдере проверяем каждый лук
    for (LookItem lookItem in folderItem.looksItems) {
      if (deleteValue.runtimeType == LookItem) {
        if (lookItem != deleteValue) {
          // если не равно удаленому луку то добавляем к спомогатльному листу
          helpLooksList.add(lookItem);
        }
      } else {
        List<ClothesItem> helpClothesList = [];
        // если найдена вещь которую надо удалить то не добавляем ее к helpLooksList
        for (ClothesItem clothesItem in lookItem.clothesItem) {
          if (clothesItem != deleteValue) {
            helpClothesList.add(clothesItem);
          }
        }
        // добавлями к листу новые сформированные луки
        if (helpClothesList.isNotEmpty) {
          helpLooksList.add(
            LookItem(
              name: lookItem.name,
              clothesItem: helpClothesList,
            ),
          );
        }
      }
      helpFoldersMap[key] = FolderItem(
        name: folderItem.name,
        looksItems: helpLooksList,
      );
    }
  }
  // удаляем все чтоб заново создать
  await boxFolders.clear();
  print(helpFoldersMap.entries);
  // кладем новые фолдеры в бокс
  boxFolders.putAll(helpFoldersMap);
}

editItemClothe(final int index, final ClothesItem clothesItem) async {
  ClothesItem? changedValue = boxClothes.getAt(index);
  await boxClothes.putAt(
    index,
    clothesItem,
  );
  boxLooks.values.toList();
  editItemLook(changedValue, clothesItem);
}

editItemLook(dynamic changedValue, dynamic newValue) async {
  //  ИЗМЕНЕНИЕ ЛУКОВ (коментрирования схоже с Фолдорами)
  final List<LookItem> responseLooks = boxLooks.values.toList();

  if (changedValue.runtimeType == LookItem) {
    String key = boxLooks.keyAt(responseLooks.indexOf(changedValue));
    await boxLooks.put(
      key,
      newValue,
    );
  } else {
    Map<dynamic, LookItem> helpLooksMap = {};
    for (var lookItem in responseLooks) {
      List<ClothesItem> helpClothesList = [];
      String key = boxLooks.keyAt(responseLooks.indexOf(lookItem));
      if (changedValue.runtimeType == LookItem) {
        if (lookItem == changedValue) {
          await boxLooks.put(
            key,
            newValue,
          );
        }
      } else {
        for (var clothesItem in lookItem.clothesItem) {
          if (clothesItem == changedValue) {
            helpClothesList.add(newValue);
          } else {
            helpClothesList.add(clothesItem);
          }
        }
        helpLooksMap[key] = LookItem(
          name: lookItem.name,
          clothesItem: helpClothesList,
        );
      }
    }
    print(helpLooksMap.entries);
    boxLooks.putAll(helpLooksMap);
  }
  editItemFolder(changedValue, newValue);
}

editItemFolder(dynamic changedValue, dynamic newValue) async {
  final List<FolderItem> responseFolders = boxFolders.values.toList();
  Map<dynamic, FolderItem> helpFoldersMap = {};
  // проверяем каждый фолдер
  for (FolderItem folderItem in responseFolders) {
    // создаем новый спомогательный лист луков внутри фолдера
    List<LookItem> helpLooksList = [];
    String key = boxFolders.keyAt(responseFolders.indexOf(folderItem));
    // в каждом фолдере проверяем каждый лук
    for (LookItem lookItem in folderItem.looksItems) {
      // если нужно заменить лук то делаем это (коментирование схожу с вещами)
      if (changedValue.runtimeType == LookItem) {
        if (lookItem == changedValue) {
          helpLooksList.add(newValue);
        } else {
          helpLooksList.add(lookItem);
        }
      } else {
        List<ClothesItem> helpClothesList = [];
        // если найдена вещь которую надо заменить то заменяем
        for (ClothesItem clothesItem in lookItem.clothesItem) {
          if (clothesItem == changedValue) {
            helpClothesList.add(newValue);
          } else {
            helpClothesList.add(clothesItem);
          }
        }
        // добавлями к листу новые сформированные луки
        helpLooksList.add(
          LookItem(
            name: lookItem.name,
            clothesItem: helpClothesList,
          ),
        );
      }
    }
    helpFoldersMap[key] = FolderItem(
      name: folderItem.name,
      looksItems: helpLooksList,
    );
  }
  // в delete очищаем box а здесь нет так как все через мапу
  // здесь все заменится по keys а в delete останется
  print(helpFoldersMap.entries);
  // кладем новые фолдеры в бокс
  boxFolders.putAll(helpFoldersMap);
}
