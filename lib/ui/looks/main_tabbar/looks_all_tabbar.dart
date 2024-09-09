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
  const LooksAllTabbar({super.key});

  @override
  State<LooksAllTabbar> createState() => _LooksAllTabbarState();
}

class _LooksAllTabbarState extends State<LooksAllTabbar> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController controllerEdit = TextEditingController();

  List? listOfFilteredLooksItems;

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredLooksItems = boxLooks.values.toList().where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredLooksItems = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return boxLooks.isEmpty
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
                itemCount: boxLooks.length,
                itemBuilder: (context, index) {
                  final LookItem lookItem = boxLooks.getAt(index)!;
                  // если поиск не использовался или если наш элемент находит в отсартированых поиском списке то показываем его
                  if (listOfFilteredLooksItems == null ||
                      listOfFilteredLooksItems!.any((element) => lookItem == element)) {
                    return CustomListViewElement(
                      index: index,
                      setState: () => setState(() {
                        searchItems();
                      }),
                      deleteFunction: () async {
                        await deleteItemFromLook(
                          boxLooks.getAt(index),
                        );
                      },
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LookCardScreen(index: index),
                          ),
                        );
                        setState(() {});
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          );
  }
}
