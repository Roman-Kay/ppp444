import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';

class CustomPopUpMenu extends StatelessWidget {
  final Function()? onPressedFirst;
  final String textFirst;
  final String svgNameFirst;
  final Function()? onPressedSecond;
  final String textSecond;
  final String svgNameSecond;
  final bool? smallIcon;

  const CustomPopUpMenu({
    super.key,
    this.onPressedFirst,
    this.onPressedSecond,
    required this.textFirst,
    required this.svgNameFirst,
    required this.textSecond,
    required this.svgNameSecond,
    this.smallIcon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: BoxConstraints(minWidth: 135.w, maxHeight: 135.w),
      color: const Color(0x00000000).withOpacity(0.3),
      shadowColor: const Color(0x00000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      itemBuilder: (context) => [
        widgetPopup(
          textFirst,
          svgNameFirst,
          onPressedFirst,
        ),
        PopupMenuItem(
          height: 1,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            height: 0.5,
            color: const Color(0xFFFAFAFA).withOpacity(0.08),
          ),
        ),
        widgetPopup(
          textSecond,
          svgNameSecond,
          onPressedSecond,
        ),
      ],
      child: SvgPicture.asset(
        'assets/images/more_vert.svg',
        // ignore: deprecated_member_use
        color: AppColors.whiteColor,
        height: smallIcon == true ? 16.h : 24.h,
      ),
    );
  }
}

PopupMenuItem widgetPopup(String text, String iconName, Function()? onTap) {
  return PopupMenuItem(
    height: 44,
    onTap: onTap,
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      children: [
        Text(
          text,
          style: AppTextStyles.bodyMedium16_400,
        ),
        const Spacer(),
        SvgPicture.asset(
          'assets/images/$iconName.svg',
          color: AppColors.basicWhiteColor,
          height: 24.h,
          width: 24.w,
          fit: BoxFit.fill,
        )
      ],
    ),
  );
}
