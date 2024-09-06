import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class Button extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool? boxShadow;

  const Button({super.key, this.onPressed, required this.text, this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 59.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primaryColor,
        boxShadow: boxShadow == true
            ? [
                BoxShadow(
                  blurRadius: 20.r,
                  color: AppColors.primaryColor.withOpacity(0.8),
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
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
