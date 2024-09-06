import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class CustomGreedView extends StatelessWidget {
  final List listOfItems;
  final Widget? bottomChild;
  // final bool? canHaveChooseCategory;
  final Widget Function(BuildContext, int) itemBuilder;
  const CustomGreedView({
    super.key,
    itemCount,
    required this.listOfItems,
    // this.canHaveChooseCategory,
    required this.itemBuilder,
    this.bottomChild,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // добавил ListView чтоб Image в base64
      // не лагали при скролле
      child: ListView(
        children: [
          MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listOfItems.length,
            crossAxisCount: 2,
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              bottom: bottomChild != null ? 0 : 40.h,
            ),
            mainAxisSpacing: 4.w,
            crossAxisSpacing: 9.w,
            itemBuilder: itemBuilder,
          ),
          if (bottomChild != null) bottomChild!,
        ],
      ),
    );
  }
}

class CustomGridViewElement extends StatelessWidget {
  final Function()? onPressed;
  final ClothesItem clothesItem;
  final bool? isChoosen;
  const CustomGridViewElement({
    super.key,
    this.onPressed,
    required this.clothesItem,
    this.isChoosen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: isChoosen == true ? AppColors.primaryColor : AppColors.surfaceColor,
      ),
      child: FormForButton(
        onPressed: onPressed,
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
                    clothesItem.category.name.split(', ').first,
                    style: AppTextStyles.bodyMedium14.copyWith(
                      color: isChoosen == true ? const Color(0xFFD3B0FF) : AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
