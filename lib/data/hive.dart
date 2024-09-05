import 'package:hive_flutter/hive_flutter.dart';

abstract class AppHive {
  final myBox = Hive.box('myBox');

  void writeData(dynamic key, dynamic value) {
    myBox.put(key, value);
  }

  void readData(dynamic key) {
    myBox.get(key);
  }

  void deleteData(dynamic key, dynamic value) {
    myBox.delete(key);
  }

  // добавить к листу элемент
  void addToListData(dynamic key, List value) {
    List valHelp = myBox.get(key);
    valHelp.add(value);
    myBox.delete(key);
    myBox.put(key, valHelp);
  }
}
