import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/settings/settings_privacy_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class SettingsMainScreen extends StatelessWidget {
  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              const CustomAppBar(text: 'Settings'),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  'Feedback and support',
                  style: AppTextStyles.displayMedium18_600.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SettingButton(
                svgName: 'email-newsletter',
                text: 'Contact Us',
                onPressed: () {},
              ),
              SizedBox(height: 4.h),
              SettingButton(
                svgName: 'face-agent',
                text: 'Support page',
                onPressed: () {},
              ),
              SizedBox(height: 4.h),
              SettingButton(
                svgName: 'comment-quote',
                text: 'Support page',
                onPressed: () {},
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  'About the program',
                  style: AppTextStyles.displayMedium18_600.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SettingButton(
                svgName: 'information-variant-circle',
                text: 'Version',
                onPressed: () {},
              ),
              SizedBox(height: 4.h),
              SettingButton(
                svgName: 'Layer_1',
                text: 'Privacy Policy',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPrivacyScreen(),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              SettingButton(
                svgName: 'Frame',
                text: 'Terms of Use',
                onPressed: () {},
              ),
              SizedBox(height: 4.h),
              SettingButton(
                svgName: 'share-all',
                text: 'Share with friends',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final String svgName;

  const SettingButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.svgName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColors.surfaceColor,
      ),
      child: FormForButton(
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/settings_list/$svgName.svg',
                height: 24.h,
              ),
              SizedBox(width: 8.w),
              Text(text, style: AppTextStyles.bodyMedium16_500),
              const Spacer(),
              SvgPicture.asset(
                'assets/images/arrow-right.svg',
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
