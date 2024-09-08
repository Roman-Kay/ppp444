// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/looks_card_screen.dart';
import 'package:ppp444/utils/modals.dart';

import 'package:ppp444/widgets/custom_list_vew.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/search.dart';

class LooksAllTabbar extends StatefulWidget {
  final List listOfLooksItems;

  const LooksAllTabbar({super.key, required this.listOfLooksItems});

  @override
  State<LooksAllTabbar> createState() => _LooksAllTabbarState();
}

class _LooksAllTabbarState extends State<LooksAllTabbar> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController controllerEdit = TextEditingController();

  List listOfLooksItems = boxLooks.values.toList();
  List listOfFilteredLooksItems = [];

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredLooksItems = listOfLooksItems.where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredLooksItems = listOfLooksItems;
    }
    setState(() {});
  }

  @override
  void initState() {
    searchItems();
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return boxLooks.values.toList().isEmpty
        ? EmptyWidget(
            topPading: 60.h,
            imageName: 'looks_empty',
            text: 'You don\'t have looks',
          )
        : Column(
            children: [
              SizedBox(height: 20.h),
              Search(searchController: searchController),
              SizedBox(height: 15.h),
              CustomListView(
                itemCount: listOfFilteredLooksItems.length,
                itemBuilder: (context, index) {
                  final LookItem lookItem = listOfFilteredLooksItems[index];
                  return CustomListViewElement(
                    lookItem: lookItem,
                    // передаем setState чтобы обновить экран
                    setState: () => setState(() {}),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LookCardScreen(lookItem: lookItem),
                        ),
                      );
                      setState(() {});
                    },
                  );
                },
              ),
            ],
          );
  }
}
