import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/wardrobe/new_clothes/new_clothes_main_screen.dart';
import 'package:ppp444/ui/wardrobe/wardrobe_clothes_card_screen.dart';
import 'package:ppp444/utils/categories.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_empty_widget.dart';
import 'package:ppp444/widgets/custom_search.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class WardrobeMainScreen extends StatefulWidget {
  const WardrobeMainScreen({super.key});

  @override
  State<WardrobeMainScreen> createState() => _WardrobeMainScreenState();
}

class _WardrobeMainScreenState extends State<WardrobeMainScreen> {
  String choosenCategory = '';
  TextEditingController searchController = TextEditingController();
  List listFilteredClothesItems = box.get('listOfClothesItems') ?? [];
  late List listOfAllClothesItems;
  late List listOfFilteredClothesItems;

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredClothesItems = listOfAllClothesItems.where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredClothesItems = listOfAllClothesItems;
    }
    setState(() {});
  }

  @override
  void initState() {
    listOfAllClothesItems = box.get('listOfClothesItems') ?? [];
    searchItems();
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25.h),
            CustomAppBar(
              needPadding: true,
              text: 'Wardrobe',
              textAddButton: 'Add Clothes',
              onPressedAddButton: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewClothesMainScreen(),
                  ),
                );
                setState(() {
                  listOfAllClothesItems = box.get('listOfClothesItems') ?? [];
                  searchItems();
                });
              },
            ),
            listOfAllClothesItems.isEmpty
                ? CustomEmptyWidget(
                    topPading: 70.h,
                    imageName: 'wardrobe_empty',
                    text: 'Wardrobe is empty',
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
                                              : choosenCategory =
                                                  Categories.listOfCategoriesItems[index].name;
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
                          // добавил SingleChildScrollView чтоб Image в base64
                          // не лагали при скролле
                          child: SingleChildScrollView(
                            child: MasonryGridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listOfFilteredClothesItems.length,
                              crossAxisCount: 2,
                              padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 40.h),
                              mainAxisSpacing: 4.w,
                              crossAxisSpacing: 9.w,
                              itemBuilder: (context, index) {
                                ClothesItem clothesItem = listOfFilteredClothesItems[index];
                                return clothesItem.category.split(', ').first == choosenCategory ||
                                        choosenCategory == ''
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.r),
                                          color: AppColors.surfaceColor,
                                        ),
                                        child: FormForButton(
                                          onPressed: () async {
                                            setState(() {});
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => WardrobeClothesCardScreen(
                                                  clothesItem: clothesItem,
                                                ),
                                              ),
                                            );
                                            // чтобы обновился лист фото
                                            setState(() {});
                                          },
                                          borderRadius: BorderRadius.circular(30.r),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5.h),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      clothesItem.name,
                                                      style: AppTextStyles.bodyMedium14,
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    Text(
                                                      clothesItem.category.split(', ').first,
                                                      style: AppTextStyles.bodyMedium14.copyWith(
                                                        color: AppColors.greyColor,
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
      ),
    );
  }
}
