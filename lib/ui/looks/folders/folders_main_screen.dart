import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/looks/folders/folder_new_look_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/form_for_button.dart';
import 'package:ppp444/widgets/widget_button.dart';

class FoldersMainScreen extends StatefulWidget {
  final FolderItem folderItem;
  const FoldersMainScreen({super.key, required this.folderItem});

  @override
  State<FoldersMainScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersMainScreen> {
  TextEditingController controller = TextEditingController();
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
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
                      'Folders',
                      style: AppTextStyles.displayMedium18_900,
                    ),
                    const Spacer(),
                    CustomPopUpMenu(
                      textFirst: 'Edit the Folder',
                      svgNameFirst: 'edit',
                      onPressedFirst: () {},
                      textSecond: 'Add New Look',
                      svgNameSecond: 'add',
                      onPressedSecond: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoldersNewLookScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Text(
                  widget.folderItem.name,
                  style: AppTextStyles.displayLarge32,
                ),
                widget.folderItem.lookstems.isEmpty
                    ? Column(
                        children: [
                          SizedBox(height: 60.h),
                          Image.asset(
                            'assets/images/folders_empty.png',
                            width: 210.w,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Folder is empty',
                            style: AppTextStyles.displayMedium18_900,
                          ),
                          SizedBox(height: 50.h),
                          WidgetButton(
                            onPressed: () {
                              showCustomDialog(
                                context,
                                'Folder Name',
                                'Change the folder name',
                                () {
                                  // setState(() {
                                  //   widget.folderItem = FolderItem(
                                  //     name: controller.text,
                                  //     ,
                                  //   );
                                  // });
                                  // Navigator.pop(context);
                                },
                                () {
                                  controller.text = '';
                                  Navigator.pop(context);
                                },
                                controller,
                              );
                            },
                            text: 'Add Looks',
                          )
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: widget.folderItem.lookstems.length,
                          itemBuilder: (context, index) {
                            final LookItem lookItem = widget.folderItem.lookstems[index];
                            return Padding(
                              padding: EdgeInsets.only(top: 15.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  height: 189.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color: AppColors.surfaceColor,
                                  ),
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Row(
                                          children: [
                                            Text(
                                              lookItem.name,
                                              style: AppTextStyles.displayBold20,
                                            ),
                                            const Spacer(),
                                            CustomPopUpMenu(
                                              textFirst: 'Edit the Folder',
                                              svgNameFirst: 'edit',
                                              onPressedFirst: () {
                                                showCustomDialog(
                                                  context,
                                                  'Edit Look',
                                                  'Give a name to the look',
                                                  () {
                                                    setState(() {
                                                      widget.folderItem.lookstems[index] = LookItem(
                                                        name: controller.text,
                                                        clothesItem: lookItem.clothesItem,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  () {
                                                    controller.text = '';
                                                    Navigator.pop(context);
                                                  },
                                                  controller,
                                                );
                                              },
                                              textSecond: 'Delete from folder',
                                              svgNameSecond: 'delete',
                                              onPressedSecond: () {
                                                setState(() {
                                                  widget.folderItem.lookstems.removeAt(index);
                                                });
                                              },
                                              smallIcon: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // высота элементов в ListView 120.h
                                        // 15.h с верху и снизу для удобного скролла
                                        height: 120.h + 30.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.h, horizontal: 14.w),
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
                                                    'assets/images/clothes/dress.png',
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
  }
}
