import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';

class CustomTextFieldLabel extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? hintText;
  final Color? hintColor;
  final Widget? icon;

  const CustomTextFieldLabel({
    super.key,
    required this.controller,
    this.onChanged,
    this.icon,
    this.hintText,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            icon ?? const SizedBox(),
            Expanded(
              child: TextFormField(
                controller: controller,
                onChanged: onChanged,
                style: AppTextStyles.bodyMedium14.copyWith(
                  color: AppColors.blackColor,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: hintText,
                  hintStyle: AppTextStyles.bodyMedium14.copyWith(
                    color: AppColors.placeHolderColor,
                  ),
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
