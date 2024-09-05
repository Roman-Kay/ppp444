import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/looks/main_tabbar/looks_all_tabbar.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';
import 'package:ppp444/widgets/form_for_button.dart';
import 'package:ppp444/widgets/widget_button.dart';

class FoldersNewLookScreen extends StatefulWidget {
  const FoldersNewLookScreen({super.key});

  @override
  State<FoldersNewLookScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersNewLookScreen> {
  TextEditingController controller = TextEditingController();

  List<LookItem> choossenLookItem = [];
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Row(
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
                          'Back',
                          style: AppTextStyles.displayMedium18_900,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: 'Search...',
                      iconLeft: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset('assets/images/search.svg'),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listOfLooksItems.length,
                        padding: EdgeInsets.only(bottom: 200.h),
                        itemBuilder: (context, index) {
                          final LookItem lookItem = listOfLooksItems[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              clipBehavior: Clip.hardEdge,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                height: 189.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: choossenLookItem.any((element) => element == lookItem)
                                      ? AppColors.primaryColor
                                      : AppColors.surfaceColor,
                                ),
                                child: FormForButton(
                                  onPressed: () {
                                    setState(() {
                                      if (choossenLookItem.any((element) => element == lookItem)) {
                                        (choossenLookItem.remove(lookItem));
                                      } else {
                                        choossenLookItem.add(lookItem);
                                      }
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            lookItem.name,
                                            style: AppTextStyles.displayBold20,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        // высота элементов в ListView 120.h
                                        // 15.h с верху и снизу для удобного скролла
                                        height: 120.h + 30.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15.h,
                                            horizontal: 14.w,
                                          ),
                                          itemCount: lookItem.clothesItem.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: index != 0 ? 4 : 0,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(24.r),
                                                  child: Image.asset(
                                                    'assets/images/clothes/${lookItem.clothesItem[index].imageName}.png',
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom >= 10 ? 10.h : 20.h,
                      ),
                      child: WidgetButton(
                        text: 'Confirm',
                        boxShadow: true,
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
