import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/wardrobe/wardrobe_main_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class WardrobeClothesCardScreen extends StatelessWidget {
  final ClothesItem clothesItem;
  const WardrobeClothesCardScreen({super.key, required this.clothesItem});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                      'Wardrobe',
                      style: AppTextStyles.displayMedium18_900,
                    ),
                    const Spacer(),
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(12.r),
                      child: PopupMenuButton(
                        constraints: BoxConstraints(minWidth: 135.w, maxHeight: 135.w),
                        color: const Color(0x00000000).withOpacity(0.3),
                        shadowColor: const Color(0x00000000),
                        onSelected: (value) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            height: 44,
                            child: Row(
                              children: [
                                Text(
                                  'Edit',
                                  style: AppTextStyles.bodyMedium16_400,
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/images/edit.svg',
                                  height: 24.h,
                                )
                              ],
                            ),
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
                          PopupMenuItem(
                            height: 44,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                            child: Row(
                              children: [
                                Text(
                                  'Delete',
                                  style: AppTextStyles.bodyMedium16_400,
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/images/delete.svg',
                                  height: 24.h,
                                )
                              ],
                            ),
                          ),
                        ],
                        child: SvgPicture.asset(
                          'assets/images/more_vert.svg',
                          color: AppColors.whiteColor,
                          height: 24.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/images/clothes/${clothesItem.imageName}.png',
                      fit: BoxFit.fill,
                      width: 390.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clothesItem.name,
                      style: AppTextStyles.displayLarge32,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      clothesItem.category,
                      style: AppTextStyles.displayMedium18_600.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom >= 10 ? 4.h : 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
