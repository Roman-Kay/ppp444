// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class LookCardScreen extends StatelessWidget {
  final LookItem lookItem;
  const LookCardScreen({super.key, required this.lookItem});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Looks',
                      style: AppTextStyles.displayMedium18_900,
                    ),
                    const Spacer(),
                    CustomPopUpMenu(
                      textFirst: 'Edit',
                      svgNameFirst: 'edit',
                      onPressedFirst: () {},
                      textSecond: 'Delete',
                      svgNameSecond: 'delete',
                      onPressedSecond: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  children: [
                    SizedBox(height: 15.h),
                    MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lookItem.clothesItem.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.w,
                      crossAxisSpacing: 9.w,
                      itemBuilder: (context, index) {
                        ClothesItem clothesItem = lookItem.clothesItem[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(25.r),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            //
                            'assets/images/clothes/dress.png',
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      lookItem.name,
                      style: AppTextStyles.displayLarge32,
                    ),
                    SizedBox(height: 5.h),
                    for (var element in lookItem.clothesItem)
                      Text(
                        element.name,
                        style: AppTextStyles.bodyMedium14.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom >= 10 ? 4.h : 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
