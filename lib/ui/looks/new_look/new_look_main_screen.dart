import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppp444/ui/looks/new_look/new_look_choosing_clothes_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';
import 'package:ppp444/widgets/form_for_button.dart';
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
                          child: SizedBox(
                            height: 120.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: choossenClothesItems.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: index != 0 ? 4 : 0,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24.r),
                                      child: Image.asset(
                                        'assets/images/clothes/${choossenClothesItems[index].imageName}.png',
                                        height: 120.h,
                                        width: 120.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
              duration: const Duration(milliseconds: 100),
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
                    child: WidgetButton(
                      text: 'Add Look',
                      onPressed: () {},
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
