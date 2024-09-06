import 'package:hive_flutter/hive_flutter.dart';

late Box box;

addToList(String key, dynamic value) {
  List helpList = box.get(key) ?? [];
  helpList.add(value);
  box.put(key, helpList);
  print(box.get(key));
}
