import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class WardrobeClothesCardScreen extends StatefulWidget {
  final ClothesItem clothesItem;
  WardrobeClothesCardScreen({super.key, required this.clothesItem});

  @override
  State<WardrobeClothesCardScreen> createState() => _WardrobeClothesCardScreenState();
}

class _WardrobeClothesCardScreenState extends State<WardrobeClothesCardScreen> {
  final TextEditingController controller = TextEditingController();

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
                    CustomPopUpMenu(
                      textFirst: 'Edit',
                      svgNameFirst: 'edit',
                      onPressedFirst: () {
                        showCustomDialog(context, 'Сloth Name', 'Change the cloth name', () {
                          setState(
                            () {
                              final List response = box.get('listOfClothesItems');
                              // print(response[0].name);

                              print(widget.clothesItem.name == response[0].name);
                              print(widget.clothesItem.imageBase64 == response[0].imageBase64);
                              print(widget.clothesItem.category == response[0].category);
                              print(response.indexOf(widget.clothesItem));
                              editItemInList(
                                widget.clothesItem,
                                ClothesItem(
                                  category: widget.clothesItem.category,
                                  name: controller.text,
                                  imageBase64: widget.clothesItem.imageBase64,
                                ),
                              );
                              widget.clothesItem.name = controller.text;
                              controller.text = '';
                              Navigator.pop(context);
                            },
                          );
                        }, () {
                          controller.text = '';
                          Navigator.pop(context);
                        }, controller, (valeu) {});
                      },
                      textSecond: 'Delete',
                      svgNameSecond: 'delete',
                      onPressedSecond: () {
                        deleteItemFromList(widget.clothesItem);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    clipBehavior: Clip.hardEdge,
                    child: Image.memory(
                      base64Decode(widget.clothesItem.imageBase64),
                      fit: BoxFit.fitWidth,
                      width: 390.w,
                      // height: 590.h,
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
                      widget.clothesItem.name,
                      style: AppTextStyles.displayLarge32,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      widget.clothesItem.category,
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
