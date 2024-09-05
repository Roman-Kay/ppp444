// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/new_clothes/choosen_catogory.dart';
import 'package:ppp444/ui/new_clothes/pick_image_sheet.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class NewClothesMainScreen extends StatefulWidget {
  const NewClothesMainScreen({super.key});

  @override
  State<NewClothesMainScreen> createState() => _NewClothesMainScreenState();
}

class _NewClothesMainScreenState extends State<NewClothesMainScreen> {
  final TextEditingController controllerCategory = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          children: [
            SizedBox(height: 25.h),
            SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Container(
                    width: 32.h,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: FormForButton(
                      onPressed: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        'assets/images/keyboard_backspace.svg',
                        color: AppColors.whiteColor,
                        height: 32.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'New Clothes',
                    style: AppTextStyles.displayMedium18_900,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: image != null
                  ? ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(25.r),
                      child: Image.file(
                        image!,
                        height: 240.r,
                        width: 350.w,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      width: 240.r,
                      height: 240.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.surfaceColor,
                      ),
                      child: FormForButton(
                        borderRadius: BorderRadius.circular(30.r),
                        onPressed: () async {
                          image = await pickImageSheet(context);
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/add_a_photo.svg',
                            height: 96.r,
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.surfaceColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: AppTextStyles.displayMedium18_600.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: controllerName,
                      hintText: 'Favorite hat',
                      isBig: true,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Category',
                      style: AppTextStyles.displayMedium18_600.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: controllerCategory,
                      hintText: 'Hats, T-shirts, Jeans...',
                      isBig: true,
                      onPressed: () async {
                        final List<String> response = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChossenCategory(),
                          ),
                        );
                        controllerCategory.text = '${response.first}, ${response.last}';
                      },
                      iconRight: SvgPicture.asset(
                        'assets/images/chevron_left.svg',
                        height: 24.h,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
