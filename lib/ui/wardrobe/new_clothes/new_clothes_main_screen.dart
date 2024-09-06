// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/wardrobe/new_clothes/choosen_catogory.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';
import 'package:ppp444/widgets/widget_button.dart';

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
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              children: [
                SizedBox(height: 25.h),
                const SafeArea(
                  bottom: false,
                  child: CustomAppBar(text: 'New Clothes', needArrow: true),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.basicWhiteColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SafeArea(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 20.h),
                                    Button(
                                      text: 'Выбрать из галереи',
                                      onPressed: () async {
                                        image = await getImage(ImageSource.gallery);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(height: 20.h),
                                    Button(
                                      text: 'Сделать фото',
                                      onPressed: () async {
                                        image = await getImage(ImageSource.camera);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: image != null
                        ? ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(25.r),
                            child: Image.file(
                              image!,
                              height: 240.r,
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
                          onChanged: (value) => setState(() {}),
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
                            final response = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChossenCategory(),
                              ),
                            );
                            if (response != null) {
                              setState(() {
                                controllerCategory.text = '${response.first}, ${response.last}';
                              });
                            }
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
            AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: controllerCategory.text.isNotEmpty &&
                      controllerName.text.isNotEmpty &&
                      image != null
                  ? 1
                  : 0,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      bottom: MediaQuery.of(context).padding.bottom >= 10 ? 30.h : 40.h,
                    ),
                    child: Button(
                      text: 'Add clothes',
                      onPressed: () {
                        addToList(
                          ClothesItem(
                            imageBase64: base64Encode(image!.readAsBytesSync()),
                            name: controllerName.text,
                            category: controllerCategory.text,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future getImage(ImageSource source) async {
  final image = await ImagePicker().pickImage(source: source);
  if (image == null) return null;
  return File(image.path);
}
