// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_grid_view.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';

class LookCardScreen extends StatefulWidget {
  final LookItem lookItem;
  const LookCardScreen({super.key, required this.lookItem});

  @override
  State<LookCardScreen> createState() => _LookCardScreenState();
}

class _LookCardScreenState extends State<LookCardScreen> {
  late LookItem lookItem;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    lookItem = widget.lookItem;
    super.initState();
  }

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
              CustomAppBar(
                text: 'Looks',
                needArrow: true,
                needPadding: true,
                customPopUpMenu: CustomPopUpMenu(
                  textFirst: 'Edit',
                  svgNameFirst: 'edit',
                  onPressedFirst: () {
                    showCustomDialog(
                        context,
                        'Look Name',
                        'Change the look name',
                        () {
                          setState(
                            () {
                              // editItemNameLook(
                              //   widget.lookItem,
                              //   LookItem(
                              //     clothesItem: widget.lookItem.clothesItem,
                              //     name: controller.text,
                              //   ),
                              // );
                              controller.text = '';
                              Navigator.pop(context);
                              // getClothes();
                            },
                          );
                        },
                        () {
                          controller.text = '';
                          Navigator.pop(context);
                        },
                        controller,
                        (valeu) {
                          setState(() {});
                        });
                  },
                  textSecond: 'Delete',
                  svgNameSecond: 'delete',
                  onPressedSecond: () {
                    // deleteItemNameLook(lookItem);
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10.h),
              CustomGreedView(
                listOfItems: widget.lookItem.clothesItem,
                itemBuilder: (context, index) {
                  ClothesItem clothesItem = lookItem.clothesItem[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    clipBehavior: Clip.hardEdge,
                    child: Image.memory(
                      base64Decode(clothesItem.imageBase64),
                      gaplessPlayback: true,
                    ),
                  );
                },
                bottomChild: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.h),
                        Text(
                          lookItem.name,
                          style: AppTextStyles.displayLarge32,
                        ),
                        SizedBox(height: 5.h),
                        for (var element in lookItem.clothesItem)
                          Text(
                            element.name,
                            style: AppTextStyles.bodyMedium14.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom >= 10 ? 4.h : 15.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
