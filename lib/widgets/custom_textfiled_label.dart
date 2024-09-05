import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Color? backGroundColor;
  final String? hintText;
  final Color? hintColor;
  final Widget? icon;
  final bool? isCupertino;

  const CustomTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.icon,
    this.hintText,
    this.hintColor,
    this.backGroundColor,
    this.isCupertino,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isCupertino == true ? null : 50.h,
      decoration: BoxDecoration(
        borderRadius: isCupertino == true ? BorderRadius.circular(7) : BorderRadius.circular(15.r),
        color: isCupertino == true ? const Color(0xFF1C1C1E) : AppColors.whiteColor,
        border: isCupertino == true
            ? Border.all(
                color: const Color(0xFF58575D),
                width: 0.5,
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isCupertino == true ? 8 : 15.w,
          vertical: isCupertino == true ? 8 : 0,
        ),
        child: Row(
          children: [
            icon ?? const SizedBox(),
            Expanded(
              child: TextFormField(
                controller: controller,
                onChanged: onChanged,
                style: isCupertino == true
                    ? AppTextStyles.bodyMedium12.copyWith(color: const Color(0xFF58575D))
                    : AppTextStyles.bodyMedium14.copyWith(
                        color: AppColors.blackColor,
                      ),
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: hintText,
                  hintStyle: isCupertino == true
                      ? AppTextStyles.bodyMedium12.copyWith(color: const Color(0xFF58575D))
                      : AppTextStyles.bodyMedium14.copyWith(
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
