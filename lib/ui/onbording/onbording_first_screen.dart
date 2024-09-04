import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/ui/onbording/onbording_second_screen.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/widget_button.dart';

class OnbordingFirstScreen extends StatelessWidget {
  const OnbordingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/gradient_first.png',
            height: 844.h,
            width: 390.w,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 96.h),
                Image.asset(
                  'assets/images/people.png',
                  width: 366.w,
                  height: 366.h,
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    'Create stylish looks and organize your wardrobe',
                    style: AppTextStyles.displayLarge32,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: WidgetButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnbordingSecondScreen(),
                      ),
                    ),
                    text: 'Continue',
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
