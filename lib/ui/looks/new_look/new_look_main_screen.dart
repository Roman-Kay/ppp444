import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/new_look/new_look_choosing_clothes_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_list_vew.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';
import 'package:ppp444/widgets/widget_button.dart';

class NewLookMainScreen extends StatefulWidget {
  const NewLookMainScreen({super.key});

  @override
  State<NewLookMainScreen> createState() => _NewLookMainScreenState();
}

class _NewLookMainScreenState extends State<NewLookMainScreen> {
  final TextEditingController controllerCategory = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  List<ClothesItem> choossenClothesItems = [];

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
                  child: CustomAppBar(text: 'New Look', needArrow: true),
                ),
                SizedBox(height: 30.h),
                containerWithTextField(
                  'Name',
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomTextField(
                      controller: controllerName,
                      hintText: 'Favorite hat',
                      onChanged: (value) => setState(() {}),
                      isBig: true,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                containerWithTextField(
                  'Elements of clothes',
                  choossenClothesItems.isNotEmpty
                      ? GestureDetector(
                          onTap: () async {
                            final response = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewLookChoosingClothesScreen(),
                              ),
                            );
                            if (response != null) {
                              setState(() {
                                choossenClothesItems = response;
                              });
                            }
                          },
                          child: ListViewHorizontalElement(
                            clothesItem: choossenClothesItems,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomTextField(
                            controller: controllerCategory,
                            hintText: 'Hats, T-shirts, Jeans...',
                            isBig: true,
                            onPressed: () async {
                              final response = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NewLookChoosingClothesScreen(),
                                ),
                              );
                              if (response != null) {
                                setState(() {
                                  choossenClothesItems = response;
                                });
                              }
                            },
                            iconRight: SvgPicture.asset(
                              'assets/images/chevron_left.svg',
                              height: 24.h,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: controllerName.text.isNotEmpty && choossenClothesItems.isNotEmpty ? 1 : 0,
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
                      text: 'Add Look',
                      onPressed: () {
                        for (var clothesItem in choossenClothesItems) {
                          List<String> newLooks = clothesItem.looks!;
                          newLooks.add(controllerName.text);
                          editItemInList(
                            clothesItem,
                            ClothesItem(
                              imageBase64: clothesItem.imageBase64,
                              name: clothesItem.name,
                              category: clothesItem.category,
                              looks: newLooks,
                            ),
                          );
                        }
                        // addToList(
                        //   ClothesItem(imageBase64: imageBase64, name: name, category: category)
                        //   LookItem(
                        //     name: controllerName.text,
                        //     clothesItem: choossenClothesItems,
                        //   ),
                        // );
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

Widget containerWithTextField(String name, Widget textField) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.r),
      color: AppColors.surfaceColor,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Text(
              name,
              style: AppTextStyles.displayMedium18_600.copyWith(
                color: AppColors.greyColor,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          textField,
        ],
      ),
    ),
  );
}
