import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class WidgetButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  const WidgetButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 59.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primaryColor,
      ),
      child: FormForButton(
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(20.r),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium16_500,
          ),
        ),
      ),
    );
  }
}
