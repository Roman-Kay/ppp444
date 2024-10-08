// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/main_tabbar/looks_all_tabbar.dart';
import 'package:ppp444/ui/looks/main_tabbar/looks_folders_tabbar.dart';
import 'package:ppp444/ui/looks/new_look/new_look_main_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class LooksMainScreen extends StatefulWidget {
  const LooksMainScreen({super.key});

  @override
  State<LooksMainScreen> createState() => _LooksMainScreenState();
}

class _LooksMainScreenState extends State<LooksMainScreen> {
  int chossenCategory = 0;

  final TextEditingController controller = TextEditingController();

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
            children: [
              SizedBox(height: 25.h),
              CustomAppBar(
                text: 'Looks',
                textAddButton: chossenCategory == 0 ? 'Add Look' : 'Add Folder',
                onPressedAddButton: chossenCategory == 0
                    ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewLookMainScreen(),
                          ),
                        );
                        setState(() {});
                      }
                    : () {
                        showCustomDialog(
                          context,
                          'New Folder',
                          'Give a name to the new folder',
                          () {
                            if (controller.text.isNotEmpty) {
                              boxFolders.put(
                                generateKey(),
                                FolderItem(
                                  name: controller.text,
                                  looksItems: [],
                                ),
                              );
                            }
                            controller.text = '';
                            Navigator.pop(context);
                          },
                          () {
                            controller.text = '';
                            Navigator.pop(context);
                          },
                          controller,
                          (valeu) {
                            setState(() {});
                          },
                        );
                      },
              ),
              SizedBox(height: 28.h),
              // кастомный СupertinoNavBar
              Container(
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFD3B0FF),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        alignment:
                            chossenCategory == 0 ? Alignment.centerLeft : Alignment.centerRight,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          // из ширины экрана удалил padding внутри Container
                          // и снаружи его
                          width: (390.w - 4 - 24.w) / 2,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormForButton(
                              onPressed: () => setState(() {
                                chossenCategory = 0;
                              }),
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: Text(
                                  'All Looks',
                                  style: AppTextStyles.bodyMedium16_400.copyWith(
                                    color: chossenCategory == 0
                                        ? AppColors.whiteColor
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormForButton(
                              onPressed: () => setState(() {
                                chossenCategory = 1;
                              }),
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: Text(
                                  'Folders',
                                  style: AppTextStyles.bodyMedium16_400.copyWith(
                                    color: chossenCategory == 1
                                        ? AppColors.whiteColor
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                // констаты надо убрать чтобы tabbar-ы обновились
                child: [
                  // ignore: prefer_const_constructors
                  LooksAllTabbar(),
                  // ignore: prefer_const_constructors
                  LooksFoldersTabbar(),
                ][chossenCategory],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
