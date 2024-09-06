// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/looks_card_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/search.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class LooksAllTabbar extends StatefulWidget {
  final List listOfLooksItems;

  const LooksAllTabbar({super.key, required this.listOfLooksItems});

  @override
  State<LooksAllTabbar> createState() => _LooksAllTabbarState();
}

class _LooksAllTabbarState extends State<LooksAllTabbar> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController controllerEdit = TextEditingController();

  late List listOfLooksItems;
  late List listOfFilteredLooksItems;

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
    listOfLooksItems = widget.listOfLooksItems;
    searchItems();
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listOfLooksItems.isEmpty
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
              // также + 15.h из top padding первого айтома из ListView
              // это чтобы увеличить площадь скролла
              Expanded(
                child: ListView.builder(
                  itemCount: listOfFilteredLooksItems.length,
                  padding: EdgeInsets.only(bottom: 50.h),
                  itemBuilder: (context, index) {
                    final LookItem lookItem = listOfFilteredLooksItems[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          height: 189.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: AppColors.surfaceColor,
                          ),
                          child: FormForButton(
                            borderRadius: BorderRadius.circular(30.r),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LookCardScreen(lookItem: lookItem),
                                ),
                              );
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        lookItem.name,
                                        style: AppTextStyles.displayBold20,
                                      ),
                                      const Spacer(),
                                      CustomPopUpMenu(
                                        textFirst: 'Edit',
                                        svgNameFirst: 'edit',
                                        onPressedFirst: () {
                                          showCustomDialog(
                                            context,
                                            'Look Name',
                                            'Change the look name',
                                            () {
                                              setState(
                                                () {
                                                  editItemInList(
                                                    lookItem,
                                                    LookItem(
                                                      clothesItem: lookItem.clothesItem,
                                                      name: controllerEdit.text,
                                                    ),
                                                  );

                                                  controllerEdit.text = '';
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            () {
                                              controllerEdit.text = '';
                                              Navigator.pop(context);
                                            },
                                            controllerEdit,
                                            (valeu) {},
                                          );
                                        },
                                        textSecond: 'Delete',
                                        svgNameSecond: 'delete',
                                        onPressedSecond: () {
                                          deleteItemFromList(lookItem);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // высота элементов в ListView 120.h
                                  // 15.h с верху и снизу для удобного скролла
                                  height: 120.h + 30.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 14.w),
                                    itemCount: lookItem.clothesItem.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: index != 0 ? 4 : 0,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(24.r),
                                            child: Image.memory(
                                              base64Decode(lookItem.clothesItem[index].imageBase64),
                                              height: 120.h,
                                              width: 120.h,
                                              fit: BoxFit.cover,
                                              gaplessPlayback: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
