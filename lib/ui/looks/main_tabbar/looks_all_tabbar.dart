// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/looks/looks_card_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';
import 'package:ppp444/widgets/form_for_button.dart';

final List<LookItem> listOfLooksItems = [
  // LookItem(
  //   name: 'Summer vibe',
  //   clothesItem: [
  //     ClothesItem(
  //       category: 'Accessories',
  //       imageName: 'hat',
  //       name: 'Summer hat',
  //     ),
  //     ClothesItem(
  //       category: 'Casual clothes',
  //       imageName: 'dress',
  //       name: 'Dress with flowers',
  //     ),
  //     ClothesItem(
  //       category: 'Shoes',
  //       imageName: 'shoes_1',
  //       name: 'Stylish sandals',
  //     ),
  //   ],
  // ),
  // LookItem(
  //   name: 'Evening walk',
  //   clothesItem: [
  //     ClothesItem(
  //       category: 'Casual clothes',
  //       imageName: 'shirt',
  //       name: 'Casual shirt',
  //     ),
  //     ClothesItem(
  //       category: 'Shoes',
  //       imageName: 'shoes_1',
  //       name: 'Stylish sandals',
  //     ),
  //     ClothesItem(
  //       category: 'Shoes',
  //       imageName: 'shoes_2',
  //       name: 'White sneakers',
  //     ),
  //   ],
  // ),
  // LookItem(
  //   name: 'Birthday party',
  //   clothesItem: [
  //     ClothesItem(
  //       category: 'Casual clothes',
  //       imageName: 'dress',
  //       name: 'Dress with flowers',
  //     ),
  //     ClothesItem(
  //       category: 'Casual clothes',
  //       imageName: 'shirt',
  //       name: 'Casual shirt',
  //     ),
  //     ClothesItem(
  //       category: 'Shoes',
  //       imageName: 'hat',
  //       name: 'Stylish sandals',
  //     ),
  //     ClothesItem(
  //       category: 'Shoes',
  //       imageName: 'shoes_2',
  //       name: 'White sneakers',
  //     ),
  // ],
  // ),
];

class LooksAllTabbar extends StatefulWidget {
  LooksAllTabbar({super.key});

  @override
  State<LooksAllTabbar> createState() => _LooksAllTabbarState();
}

class _LooksAllTabbarState extends State<LooksAllTabbar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return listOfLooksItems.isEmpty
        ? Column(
            children: [
              SizedBox(height: 60.h),
              Image.asset(
                'assets/images/looks_empty.png',
                width: 210.w,
              ),
              SizedBox(height: 15.h),
              Text(
                'You don\'t have folders',
                style: AppTextStyles.displayMedium18_900,
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(height: 20.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Search...',
                iconLeft: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset('assets/images/search.svg'),
                ),
              ),
              SizedBox(height: 15.h),
              // также + 15.h из top padding первого айтома из ListView
              // это чтобы увеличить площадь скролла
              Expanded(
                child: ListView.builder(
                  itemCount: listOfLooksItems.length,
                  itemBuilder: (context, index) {
                    final LookItem lookItem = listOfLooksItems[index];
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
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LookCardScreen(lookItem: lookItem),
                              ),
                            ),
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
                                        textFirst: 'Edit the look',
                                        svgNameFirst: 'edit',
                                        onPressedFirst: () {
                                          showCustomDialog(
                                            context,
                                            'Edit Look',
                                            'Give a name to the look',
                                            () {
                                              setState(() {
                                                listOfLooksItems[index] = LookItem(
                                                  name: controller.text,
                                                  clothesItem: lookItem.clothesItem,
                                                );
                                              });
                                              Navigator.pop(context);
                                            },
                                            () {
                                              controller.text = '';
                                              Navigator.pop(context);
                                            },
                                            controller,
                                          );
                                        },
                                        textSecond: 'Delete',
                                        svgNameSecond: 'delete',
                                        onPressedSecond: () {
                                          setState(() {
                                            listOfLooksItems.removeAt(index);
                                          });
                                        },
                                        smallIcon: true,
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
                                            child: Image.asset(
                                              'assets/images/clothes/dress.png',
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
          );
  }
}
