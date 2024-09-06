import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_empty_widget.dart';
import 'package:ppp444/widgets/custom_search.dart';
import 'package:ppp444/widgets/form_for_button.dart';
import 'package:ppp444/widgets/widget_button.dart';

class FoldersNewLookScreen extends StatefulWidget {
  const FoldersNewLookScreen({super.key});

  @override
  State<FoldersNewLookScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersNewLookScreen> {
  TextEditingController controller = TextEditingController();

  List<LookItem> choossenLookItem = [];

  late List listOfLooksItems;
  late List listOfFilteredLooksItems;
  final TextEditingController searchController = TextEditingController();

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
    listOfLooksItems = box.get('listOfLooksItems') ?? [];
    searchItems();
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    const CustomAppBar(text: 'Back', needArrow: true),
                    listOfLooksItems.isEmpty
                        ? CustomEmptyWidget(
                            topPading: 60.h,
                            imageName: 'looks_empty',
                            text: 'You don\'t have looks',
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                CustomSearch(searchController: searchController),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: listOfFilteredLooksItems.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(bottom: 150.h),
                                    itemBuilder: (context, index) {
                                      final LookItem lookItem = listOfFilteredLooksItems[index];
                                      return Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30.r),
                                          clipBehavior: Clip.hardEdge,
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 100),
                                            height: 189.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30.r),
                                              color: choossenLookItem
                                                      .any((element) => element == lookItem)
                                                  ? AppColors.primaryColor
                                                  : AppColors.surfaceColor,
                                            ),
                                            child: FormForButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (choossenLookItem
                                                      .any((element) => element == lookItem)) {
                                                    (choossenLookItem.remove(lookItem));
                                                  } else {
                                                    choossenLookItem.add(lookItem);
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  const Spacer(),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        lookItem.name,
                                                        style: AppTextStyles.displayBold20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    // высота элементов в ListView 120.h
                                                    // 15.h с верху и снизу для удобного скролла
                                                    height: 120.h + 30.h,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: 15.h,
                                                        horizontal: 14.w,
                                                      ),
                                                      itemCount: lookItem.clothesItem.length,
                                                      itemBuilder: (context, index) {
                                                        return Center(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                              left: index != 0 ? 4 : 0,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(24.r),
                                                              child: Image.memory(
                                                                base64Decode(
                                                                  lookItem.clothesItem[index]
                                                                      .imageBase64,
                                                                ),
                                                                gaplessPlayback: true,
                                                                height: 120.h,
                                                                width: 120.h,
                                                                fit: BoxFit.cover,
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
                            ),
                          ),
                  ],
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: choossenLookItem.isEmpty ? 0 : 1,
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom >= 10 ? 10.h : 20.h,
                        ),
                        child: WidgetButton(
                          text: 'Confirm',
                          boxShadow: true,
                          onPressed: () {
                            Navigator.pop(
                              context,
                              choossenLookItem,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
