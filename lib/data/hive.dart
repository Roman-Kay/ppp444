import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/utils/modals.dart';

late Box box;

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

deleteItemFromClothe(dynamic value) {
  final responseClothes = box.get('listOfClothesItems');
  if (responseClothes != null && responseClothes != []) {
    List helpListClothes = responseClothes;
    helpListClothes.removeWhere((element) => element == value);
    box.put('listOfClothesItems', helpListClothes);
    deleteItemNameLook(value);
  }
}

deleteItemNameLook(dynamic value) {
  final responseLooks = box.get('listOfLooksItems');
  if (responseLooks != null) {
    List<LookItem> helpLooksList = [];
    for (var lookItem in responseLooks) {
      if (value.runtimeType == LookItem) {
        if (lookItem != value) {
          helpLooksList.add(lookItem);
        }
      } else if (lookItem.clothesItem.any((element) => element == value) == false) {
        helpLooksList.add(lookItem);
      }
    }
    box.delete('listOfLooksItems');
    box.put('listOfLooksItems', helpLooksList);
  }
  deleteItemNameFolder(value);
}

deleteItemNameFolder(dynamic value) {
  final responseFolders = box.get('listOfFoldersItems');
  if (responseFolders != null) {
    // создаем новый спомогательный лист фолдеров
    List helpListFolders = [];
    // проверяем каждый фолдер
    for (var folderItem in responseFolders) {
      // создаем новый спомогательный лист луков внутри фолдера
      List<LookItem> helpLooksList = [];
      // в каждом фолдере проверяем каждый лук
      folderItem.looksItems.forEach((looksItem) {
        // если найдена вещь которую надо удалить то ничего не делаем
        if (looksItem.clothesItem.any((element) => element == value)) {
          null;
        } else {
          // если вещи нет в списке лука то добавляем его к новому списку helpLooksList
          helpLooksList.add(looksItem);
        }
      });
      // когда лук сформирован добавляем его к листу из всех луков фолдера
      helpListFolders.add(FolderItem(
        name: folderItem.name,
        looksItems: helpLooksList,
      ));
    }
    // чистим список фолдеров
    box.delete('listOfFoldersItems');
    // кладем новый список
    box.put('listOfFoldersItems', helpListFolders);
  }
}

// deleteItemFromList(dynamic value) {
//   // если меняется вещь то меняем и лук с этой вещью и лук в фолдере
//   if (value.runtimeType == ClothesItem) {
//     // лист вещей
//     final responseClothes = box.get('listOfClothesItems');
//     // лист луков
//     final responseLooks = box.get('listOfLooksItems');
//     // лист фолдеров
//     final responseFolders = box.get('listOfFoldersItems');

//     if (responseClothes != null && responseClothes != []) {
//       // УДАЛЕНИЯ ИЗ ЛУКОВ (коментрирования схоже с Фолдорами)
//       if (responseLooks != null) {
//         List<LookItem> helpLooksList = [];
//         for (var lookItem in responseLooks) {
//           if (lookItem.clothesItem.any((element) => element == value)) {
//             null;
//           } else {
//             helpLooksList.add(lookItem);
//           }
//         }
//         box.delete('listOfLooksItems');
//         box.put('listOfLooksItems', helpLooksList);
//       }

//       // УДАЛЕНИЯ ИЗ ЛУКА ВНУТРИ ФОЛДЕРОВ
//       if (responseFolders != null) {
//         // создаем новый спомогательный лист фолдеров
//         List helpListFolders = [];
//         // проверяем каждый фолдер
//         for (var folderItem in responseFolders) {
//           // создаем новый спомогательный лист луков внутри фолдера
//           List<LookItem> helpLooksList = [];
//           // в каждом фолдере проверяем каждый лук
//           folderItem.looksItems.forEach((looksItem) {
//             // если найдена вещь которую надо удалить то ничего не делаем
//             if (looksItem.clothesItem.any((element) => element == value)) {
//               null;
//             } else {
//               // если вещи нет в списке лука то добавляем его к новому списку helpLooksList
//               helpLooksList.add(looksItem);
//             }
//           });
//           // когда лук сформирован добавляем его к листу из всех луков фолдера
//           helpListFolders.add(FolderItem(
//             name: folderItem.name,
//             looksItems: helpLooksList,
//           ));
//         }
//         // чистим список фолдеров
//         box.delete('listOfFoldersItems');
//         // кладем новый список
//         box.put('listOfFoldersItems', helpListFolders);
//       }
//     }
//   }

//   if (value.runtimeType == LookItem) {
//     return 'listOfLooksItems';
//   }
//   if (value.runtimeType == FolderItem) {
//     final response = box.get('listOfFoldersItems');
//     if (response != null && response != []) {
//       List helpList = response;
//       helpList.removeWhere((element) => element == value);
//       box.put('listOfFoldersItems', helpList);
//     }
//   }
// }

editItemNameClothe(dynamic changeValue, dynamic value) {
  final responseClothes = box.get('listOfClothesItems');
  if (responseClothes != null) {
    List helpList = responseClothes;
    int index = helpList.indexOf(changeValue);
    helpList[index] = value;
    box.put('listOfClothesItems', helpList);
    editItemNameLook(changeValue, value);
  }
}

editItemNameLook(dynamic changeValue, dynamic value) {
  // ИЗМЕНЕНИЕ ЛУКОВ (коментрирования схоже с Фолдорами)
  final responseLooks = box.get('listOfLooksItems');

  if (responseLooks != null) {
    List helpLooksList = [];
    for (var lookItem in responseLooks) {
      List<ClothesItem> helpClothesList = [];
      if (value.runtimeType == LookItem) {
        helpLooksList = responseLooks;
        int index = helpLooksList.indexOf(changeValue);
        helpLooksList[index] = value;
      } else {
        for (var clothesItem in lookItem.clothesItem) {
          if (clothesItem == changeValue) {
            helpClothesList.add(value);
          } else {
            helpClothesList.add(clothesItem);
          }
        }
        helpLooksList.add(
          LookItem(name: lookItem.name, clothesItem: helpClothesList),
        );
      }
    }
    box.delete('listOfLooksItems');
    box.put('listOfLooksItems', helpLooksList);
    editItemNameFolder(changeValue, value);
  }
}

editItemNameFolder(dynamic changeValue, dynamic value) {
  final responseFolders = box.get('listOfFoldersItems');

  if (responseFolders != null) {
    // создаем новый спомогательный лист фолдеров
    List helpListFolders = [];
    // проверяем каждый фолдер
    for (FolderItem folderItem in responseFolders) {
      if (value.runtimeType == FolderItem) {
        helpListFolders = responseFolders;
        int index = helpListFolders.indexOf(changeValue);
        helpListFolders[index] = value;
      } else {
        // создаем новый спомогательный лист луков внутри фолдера
        List<LookItem> helpLooksList = [];
        // в каждом фолдере проверяем каждый лук
        for (LookItem looksItem in folderItem.looksItems) {
          List<ClothesItem> helpClothesList = [];
          // если найдена вещь которую надо изменит то заменяем
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
      }
    }
    // чистим список фолдеров
    box.delete('listOfFoldersItems');
    // кладем новый список
    box.put('listOfFoldersItems', helpListFolders);
  }
}

// editItemNameInList(dynamic changeValue, dynamic value) {
//   if (value.runtimeType == ClothesItem) {
//     // лист вещей
//     final responseClothes = box.get('listOfClothesItems');
//     // лист луков
//     final responseLooks = box.get('listOfLooksItems');
//     // лист фолдеров
//     final responseFolders = box.get('listOfFoldersItems');

//     if (responseClothes != null && responseClothes != []) {
//       // ИЗМЕНЕНИЕ ЛУКОВ (коментрирования схоже с Фолдорами)

//       // ИЗМЕНЕНИЯ ЛУКА ВНУТРИ ФОЛДЕРОВ
//       if (responseFolders != null) {
//         // создаем новый спомогательный лист фолдеров
//         List helpListFolders = [];
//         // проверяем каждый фолдер
//         for (FolderItem folderItem in responseFolders) {
//           // создаем новый спомогательный лист луков внутри фолдера
//           List<LookItem> helpLooksList = [];
//           // в каждом фолдере проверяем каждый лук
//           for (LookItem looksItem in folderItem.looksItems) {
//             List<ClothesItem> helpClothesList = [];
//             // если найдена вещь которую надо изменит то заменяем
//             for (ClothesItem clothesItem in looksItem.clothesItem) {
//               if (clothesItem == changeValue) {
//                 helpClothesList.add(value);
//               } else {
//                 helpClothesList.add(clothesItem);
//               }
//             }
//             // добавлями к листу новые сформированные луки
//             helpLooksList.add(
//               LookItem(
//                 name: looksItem.name,
//                 clothesItem: helpClothesList,
//               ),
//             );
//           }

//           // когда фолдер сформирован добавляем его к листу из фолдеров
//           helpListFolders.add(FolderItem(
//             name: folderItem.name,
//             looksItems: helpLooksList,
//           ));
//         }
//         // чистим список фолдеров
//         box.delete('listOfFoldersItems');
//         // кладем новый список
//         box.put('listOfFoldersItems', helpListFolders);
//       }
//     }
//   }

//   if (value.runtimeType == LookItem) {
//     return 'listOfLooksItems';
//   }
//   if (value.runtimeType == FolderItem) {
//     final response = box.get('listOfFoldersItems');
//     if (response != null && response != []) {
//       List helpList = response;
//       helpList.removeWhere((element) => element == value);
//       box.put('listOfFoldersItems', helpList);
//     }
//   }
// }

List getFolders() {
  return (box.get('listOfFoldersItems') ?? []);
}

List getLooks() {
  return (box.get('listOfLooksItems') ?? []);
}
