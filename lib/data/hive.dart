import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/utils/modals.dart';

late Box<ClothesItem> boxClothes;
late Box<LookItem> boxLooks;
late Box<FolderItem> boxFolders;

// getkey(value) {
//   if (value.runtimeType == ClothesItem) {
//     return 'listOfClothesItems';
//   }
//   if (value.runtimeType == LookItem) {
//     return 'listOfLooksItems';
//   }
//   if (value.runtimeType == FolderItem) {
//     return 'listOfFoldersItems';
//   }
// }

deleteItemFromClothe(final int index) {
  ClothesItem? deleteValue = boxClothes.getAt(index);
  boxClothes.deleteAt(index);
  boxLooks.values.toList();
  deleteItemFromLook(deleteValue);
}

deleteItemFromLook(dynamic deleteValue) async {
  //  ИЗМЕНЕНИЕ ЛУКОВ (коментрирования схоже с Фолдорами)
  final List<LookItem> responseLooks = boxLooks.values.toList();
  await boxLooks.clear();
  Map<dynamic, LookItem> helpLooksMap = {};

  for (var lookItem in responseLooks) {
    List<ClothesItem> helpClothesList = [];

    for (var clothesItem in lookItem.clothesItem) {
      if (clothesItem != deleteValue) {
        helpClothesList.add(clothesItem);
      }
    }
    if (helpClothesList.isNotEmpty) {
      helpLooksMap['key_${lookItem.name}'] = LookItem(
        name: lookItem.name,
        clothesItem: helpClothesList,
      );
    }
  }
  print(helpLooksMap.entries);
  boxLooks.putAll(helpLooksMap);
  deleteItemNameFolder(deleteValue);
}

deleteItemNameFolder(dynamic deleteValue) async {
  final List<FolderItem> responseFolders = boxFolders.values.toList();
  // удаляем все чтоб заново создать
  await boxFolders.clear();
  Map<dynamic, FolderItem> helpFoldersMap = {};
  // проверяем каждый фолдер
  for (FolderItem folderItem in responseFolders) {
    if (deleteValue.runtimeType == FolderItem) {
      // helpListFolders = responseFolders;
      // debugPrint(responseFolders.toString());
      // int index = helpListFolders.indexOf(changeValue);
      // helpListFolders[index] = value;
    } else {
      // создаем новый спомогательный лист луков внутри фолдера
      List<LookItem> helpLooksList = [];
      // в каждом фолдере проверяем каждый лук
      for (LookItem looksItem in folderItem.looksItems) {
        List<ClothesItem> helpClothesList = [];
        // если найдена вещь которую надо удалить то не добавляем ее к helpLooksList
        for (ClothesItem clothesItem in looksItem.clothesItem) {
          if (clothesItem != deleteValue) {
            helpClothesList.add(clothesItem);
          }
        }
        // добавлями к листу новые сформированные луки
        if (helpClothesList.isNotEmpty) {
          helpLooksList.add(
            LookItem(
              name: looksItem.name,
              clothesItem: helpClothesList,
            ),
          );
        }
      }
      if (helpLooksList.isNotEmpty) {
        helpFoldersMap['key_${folderItem.name}'] = FolderItem(
          name: folderItem.name,
          looksItems: helpLooksList,
        );
      }
    }
  }
  print(helpFoldersMap.entries);
  // кладем новые фолдеры в бокс
  boxFolders.putAll(helpFoldersMap);
}

editItemClothe(final int index, final ClothesItem clothesItem) async {
  ClothesItem? changeValue = boxClothes.getAt(index);
  await boxClothes.putAt(
    index,
    clothesItem,
  );
  boxLooks.values.toList();
  editItemLook(clothesItem, changeValue);
}

editItemLook(dynamic value, dynamic changeValue) async {
  //  ИЗМЕНЕНИЕ ЛУКОВ (коментрирования схоже с Фолдорами)
  final List<LookItem> responseLooks = boxLooks.values.toList();
  await boxFolders.clear();
  Map<dynamic, LookItem> helpLooksMap = {};

  for (var lookItem in responseLooks) {
    List<ClothesItem> helpClothesList = [];

    for (var clothesItem in lookItem.clothesItem) {
      if (clothesItem == changeValue) {
        helpClothesList.add(value);
      } else {
        helpClothesList.add(clothesItem);
      }
    }
    helpLooksMap['key_${lookItem.name}'] = LookItem(
      name: lookItem.name,
      clothesItem: helpClothesList,
    );
  }
  print(helpLooksMap.entries);
  boxLooks.putAll(helpLooksMap);
}

editItemFolder(dynamic changeValue, dynamic value) async {
  final List<FolderItem> responseFolders = boxFolders.values.toList();
  // удаляем все чтоб заново создать
  await boxFolders.clear();
  Map<dynamic, FolderItem> helpFoldersMap = {};
  // проверяем каждый фолдер
  for (FolderItem folderItem in responseFolders) {
    if (value.runtimeType == FolderItem) {
      // helpListFolders = responseFolders;
      // debugPrint(responseFolders.toString());
      // int index = helpListFolders.indexOf(changeValue);
      // helpListFolders[index] = value;
    } else {
      // создаем новый спомогательный лист луков внутри фолдера
      List<LookItem> helpLooksList = [];
      // в каждом фолдере проверяем каждый лук
      for (LookItem looksItem in folderItem.looksItems) {
        List<ClothesItem> helpClothesList = [];
        // если найдена вещь которую надо удалить то заменяем
        for (ClothesItem clothesItem in looksItem.clothesItem) {
          if (clothesItem == changeValue) {
            helpClothesList.add(value);
          } else {
            helpClothesList.add(clothesItem);
          }
        }
        // добавлями к листу новые сформированные луки
        helpLooksList.add(
          LookItem(
            name: looksItem.name,
            clothesItem: helpClothesList,
          ),
        );
      }
      helpFoldersMap['key_${folderItem.name}'] = FolderItem(
        name: folderItem.name,
        looksItems: helpLooksList,
      );
    }
  }
  print(helpFoldersMap.entries);
  // кладем новые фолдеры в бокс
  boxFolders.putAll(helpFoldersMap);
}
