import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/text_styles.dart';

class EmptyWidget extends StatelessWidget {
  final double topPading;
  final String imageName;
  final String text;

  const EmptyWidget({
    super.key,
    required this.imageName,
    required this.text,
    required this.topPading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: topPading),
          Image.asset(
            'assets/images/$imageName.png',
            height: 210.h,
            width: 210.w,
          ),
          SizedBox(height: 15.h),
          Text(
            text,
            style: AppTextStyles.displayMedium18_900,
          ),
        ],
      ),
    );
  }
}
