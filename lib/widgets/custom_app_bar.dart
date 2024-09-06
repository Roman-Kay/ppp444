// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class CustomAppBar extends StatelessWidget {
  final bool? needPadding;
  final bool? needArrow;
  final String text;
  final String? textAddButton;
  final Function()? onPressedAddButton;
  final CustomPopUpMenu? customPopUpMenu;

  const CustomAppBar({
    super.key,
    this.needPadding,
    this.needArrow,
    required this.text,
    this.textAddButton,
    this.onPressedAddButton,
    this.customPopUpMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: needPadding == true ? 12.w : 0),
      child: Row(
        children: [
          if (needArrow == true)
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Container(
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
            ),
          Text(
            text,
            style: (needArrow == true
                ? AppTextStyles.displayMedium18_900
                : AppTextStyles.displayMedium24),
          ),
          const Spacer(),
          if (textAddButton != null && onPressedAddButton != null)
            Container(
              height: 34.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.whiteColor,
              ),
              child: FormForButton(
                onPressed: onPressedAddButton,
                borderRadius: BorderRadius.circular(10.r),
                child: Row(
                  children: [
                    SizedBox(width: 7.w),
                    SvgPicture.asset(
                      'assets/images/add.svg',
                      height: 20.h,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      textAddButton!,
                      style: AppTextStyles.bodyMedium14.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
            ),
          if (customPopUpMenu != null) customPopUpMenu!,
        ],
      ),
    );
  }
}
