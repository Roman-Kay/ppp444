import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/utils/categories.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_search.dart';
import 'package:ppp444/widgets/form_for_button.dart';
import 'package:ppp444/widgets/widget_button.dart';

class NewLookChoosingClothesScreen extends StatefulWidget {
  const NewLookChoosingClothesScreen({super.key});

  @override
  State<NewLookChoosingClothesScreen> createState() => _NewLookChoosingClothesScreentate();
}

class _NewLookChoosingClothesScreentate extends State<NewLookChoosingClothesScreen> {
  String choosenCategory = '';
  List<ClothesItem> choossenClothesItems = [];
  late List listOfFilteredClothesItems;
  late List listOfClothesItems;
  final TextEditingController searchController = TextEditingController();

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredClothesItems = listOfClothesItems.where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredClothesItems = listOfClothesItems;
    }
    setState(() {});
  }

  @override
  void initState() {
    listOfClothesItems = box.get('listOfClothesItems') ?? [];
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
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Container(
                          width: 32.h,
                          height: 32.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: FormForButton(
                            onPressed: () => Navigator.pop(context),
                            child: SvgPicture.asset(
                              'assets/images/keyboard_backspace.svg',
                              color: AppColors.whiteColor,
                              height: 32.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Back',
                          style: AppTextStyles.displayMedium18_900,
                        ),
                      ],
                    ),
                  ),
                  listOfClothesItems.isEmpty
                      ? Column(
                          children: [
                            SizedBox(height: 70.h),
                            Image.asset(
                              'assets/images/wardrobe_empty.png',
                              height: 210.h,
                              width: 210.w,
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              'Wardrobe is empty',
                              style: AppTextStyles.displayMedium18_900,
                            ),
                          ],
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 30.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: CustomSearch(searchController: searchController),
                              ),
                              SizedBox(
                                // высота элементов в ListView 26.h
                                // 15.h с верху и снизу для удобного скролла
                                height: 26.h + 30.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Categories.listOfCategoriesItems.length,
                                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: index != 0 ? 5.w : 0,
                                        ),
                                        child: Container(
                                          height: 26.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(26),
                                            color: choosenCategory ==
                                                    Categories.listOfCategoriesItems[index].name
                                                ? AppColors.primaryColor
                                                : null,
                                            border: Border.all(
                                              width: 0.5,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                          child: FormForButton(
                                            onPressed: () {
                                              setState(() {
                                                choosenCategory ==
                                                        Categories.listOfCategoriesItems[index].name
                                                    ? choosenCategory = ''
                                                    : choosenCategory = Categories
                                                        .listOfCategoriesItems[index].name;
                                              });
                                            },
                                            borderRadius: BorderRadius.circular(26.r),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 13.w),
                                              child: Text(
                                                Categories.listOfCategoriesItems[index].name,
                                                style: AppTextStyles.bodyMedium12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: MasonryGridView.count(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: listOfFilteredClothesItems.length,
                                    crossAxisCount: 2,
                                    padding:
                                        EdgeInsets.only(left: 12.w, right: 12.w, bottom: 200.h),
                                    mainAxisSpacing: 4.w,
                                    crossAxisSpacing: 9.w,
                                    itemBuilder: (context, index) {
                                      ClothesItem clothesItem = listOfFilteredClothesItems[index];
                                      return clothesItem.category.split(', ').first ==
                                                  choosenCategory ||
                                              choosenCategory == ''
                                          ? AnimatedContainer(
                                              duration: const Duration(milliseconds: 100),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.r),
                                                color: choossenClothesItems
                                                        .any((element) => element == clothesItem)
                                                    ? AppColors.primaryColor
                                                    : AppColors.surfaceColor,
                                              ),
                                              child: FormForButton(
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      choossenClothesItems.any(
                                                              (element) => element == clothesItem)
                                                          ? choossenClothesItems.remove(clothesItem)
                                                          : choossenClothesItems.add(clothesItem);
                                                    },
                                                  );
                                                },
                                                borderRadius: BorderRadius.circular(30.r),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 5.h),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(horizontal: 5.w),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(25.r),
                                                        clipBehavior: Clip.hardEdge,
                                                        child: Image.memory(
                                                          base64Decode(clothesItem.imageBase64),
                                                          gaplessPlayback: true,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(horizontal: 15.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            clothesItem.name,
                                                            style: AppTextStyles.bodyMedium14,
                                                          ),
                                                          SizedBox(height: 2.h),
                                                          Text(
                                                            clothesItem.category.split(', ').first,
                                                            style:
                                                                AppTextStyles.bodyMedium14.copyWith(
                                                              color: choossenClothesItems.any(
                                                                      (element) =>
                                                                          element == clothesItem)
                                                                  ? const Color(0xFFD3B0FF)
                                                                  : AppColors.greyColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: choossenClothesItems.isEmpty ? 0 : 1,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 12.w,
                        right: 12.w,
                        bottom: MediaQuery.of(context).padding.bottom >= 10 ? 10.h : 20.h,
                      ),
                      child: WidgetButton(
                        text: 'Confirm',
                        boxShadow: true,
                        onPressed: () => Navigator.pop(context, choossenClothesItems),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
