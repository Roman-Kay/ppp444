import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/ui/bottom_bar.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/widget_button.dart';

class OnbordingSecondScreen extends StatelessWidget {
  const OnbordingSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/gradient_second.png',
            height: 844.h,
            width: 390.w,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 96.h),
                Image.asset(
                  'assets/images/bag.png',
                  width: 366.w,
                  height: 366.h,
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    'Create folders with your looks',
                    style: AppTextStyles.displayLarge32,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Button(
                    text: 'Get Started',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomBottomBar(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
