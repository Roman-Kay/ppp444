import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';

class SettingsPrivacyScreen extends StatelessWidget {
  const SettingsPrivacyScreen({super.key});

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
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: 25.h),
              const CustomAppBar(
                needPadding: true,
                needArrow: true,
                text: 'Settings',
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  children: [
                    Text(
                      'Privacy Policy',
                      style: AppTextStyles.displayLarge32.copyWith(
                        color: AppColors.basicWhiteColor,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services. Here is where you can list and ban behaviors and activities like:',
                      style: AppTextStyles.bodyMedium16_400,
                    ),
                    textWithDot('Obscene, crude, or violent posts'),
                    textWithDot('False or misleading content'),
                    textWithDot('Breaking the law'),
                    textWithDot('Spamming or scamming the service or other users'),
                    textWithDot('Hacking or tampering with your website or app'),
                    textWithDot('Violating copyright laws'),
                    textWithDot('Harassing other users'),
                    textWithDot('Stalking other users'),
                    Text(
                      'If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.',
                      style: AppTextStyles.bodyMedium16_400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textWithDot(String text) {
  return Row(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: 1.8,
          backgroundColor: AppColors.whiteColor,
        ),
      ),
      Expanded(
        child: Text(
          text,
          style: AppTextStyles.bodyMedium16_400,
        ),
      ),
    ],
  );
}
