// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class ChossenCategory extends StatelessWidget {
  final CategoryItem? choosenCategoryItem;
  ChossenCategory({super.key, this.choosenCategoryItem});

  final List<CategoryItem> listOfCategoriesItems = [
    CategoryItem(
      name: 'Outerwear',
      subNames: [
        'Coat',
        'Jacket',
        'Cloak',
        'Down jacket',
        'Fur coat',
        'Vest',
      ],
    ),
    CategoryItem(
      name: 'Casual clothes',
      subNames: [
        'Dress',
        'T-shirt',
        'Sweatshirt',
        'Shirt',
        'Blouse',
      ],
    ),
    CategoryItem(
      name: 'Lower Clothing',
      subNames: [
        'Trousers',
        'Jeans',
        'Trousers',
        'Skirt',
        'Shorts',
      ],
    ),
    CategoryItem(
      name: 'Undergarments',
      subNames: [
        'Underpants',
        'Bra',
        'Undershirt',
      ],
    ),
    CategoryItem(
      name: 'Sports and fitness clothing',
      subNames: [
        'Sports suit',
        'Sweatpants',
        'Sports shorts',
        'Sports T-shirt',
        'Leggings',
        'Sweatshirt',
        'Sports headband',
      ],
    ),
    CategoryItem(
      name: 'Shoes',
      subNames: [
        'Sneakers',
        'Shoes',
        'Sandals',
        'Ballet shoes',
        'Boots',
        'Flip flops',
        'Sabo',
        'Sandals',
      ],
    ),
    CategoryItem(
      name: 'Evening dresses',
      subNames: [
        'Evening dress',
        'Costume',
        'Shirt',
        'Trousers',
      ],
    ),
    CategoryItem(
      name: 'Beachwear',
      subNames: [
        'Swimsuit',
        'Beach dress',
        'Sundress',
        'Swimming trunks',
      ],
    ),
    CategoryItem(
      name: 'Accessories',
      subNames: [
        'Bag',
        'Scarf',
        'Cap',
        'Hat',
        'Jewel',
      ],
    ),
  ];
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Row(
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
                if (choosenCategoryItem != null) SizedBox(height: 30.h),
                if (choosenCategoryItem != null)
                  Text(
                    choosenCategoryItem!.name,
                    style: AppTextStyles.displayMedium24,
                  ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: choosenCategoryItem != null
                        ? choosenCategoryItem!.subNames.length
                        : listOfCategoriesItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: index == 0
                              ? choosenCategoryItem != null
                                  ? 10.h
                                  : 20.h
                              : 4.h,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            color: AppColors.surfaceColor,
                          ),
                          child: FormForButton(
                            onPressed: choosenCategoryItem != null
                                ? () {
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop(
                                        [
                                          choosenCategoryItem!.name,
                                          choosenCategoryItem!.subNames[index],
                                        ],
                                      );
                                  }
                                : () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChossenCategory(
                                          choosenCategoryItem: listOfCategoriesItems[index],
                                        ),
                                      ),
                                    ),
                            borderRadius: BorderRadius.circular(20.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  Text(
                                    choosenCategoryItem != null
                                        ? choosenCategoryItem!.subNames[index]
                                        : listOfCategoriesItems[index].name,
                                    style: AppTextStyles.displayMedium18_900.copyWith(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    'assets/images/chevron_left.svg',
                                    color: AppColors.whiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
