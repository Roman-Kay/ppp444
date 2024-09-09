import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/bottom_bar.dart';
import 'package:ppp444/ui/onbording/onbording_first_screen.dart';
import 'package:ppp444/utils/modals.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ClothesItemAdapter());
  Hive.registerAdapter(FolderItemAdapter());
  Hive.registerAdapter(LookItemAdapter());
  boxFirstStart = await Hive.openBox('firstStartBox');
  boxClothes = await Hive.openBox<ClothesItem>('clothesBox');
  boxLooks = await Hive.openBox<LookItem>('looksBox');
  boxFolders = await Hive.openBox<FolderItem>('foldersBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SP PRO TEXT',
      ),
      home: ScreenUtilInit(
        // 390, 844 это - ширина и высота экранов фигмы
        // в засимости от высоты и ширины экрана нашего девайса
        // элементы будут увеличиваться и уменьшаться
        designSize: const Size(390, 844),
        builder: (context, child) {
          return boxFirstStart.get('key') == true
              ? const OnbordingFirstScreen()
              : const CustomBottomBar();
        },
      ),
    );
  }
}
