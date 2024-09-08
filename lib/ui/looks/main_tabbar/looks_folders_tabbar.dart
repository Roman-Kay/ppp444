import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/folders/folders_main_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class LooksFoldersTabbar extends StatefulWidget {
  const LooksFoldersTabbar({
    super.key,
  });

  @override
  State<LooksFoldersTabbar> createState() => _LooksFoldersTabbarState();
}

class _LooksFoldersTabbarState extends State<LooksFoldersTabbar> {
  @override
  Widget build(BuildContext context) {
    return boxFolders.isEmpty
        ? EmptyWidget(
            imageName: 'folders_empty',
            text: 'You don\'t have folders',
            topPading: 60.h,
          )
        : ListView.builder(
            itemCount: boxFolders.length,
            padding: EdgeInsets.only(bottom: 50.h),
            itemBuilder: (context, index) {
              final FolderItem folderItem = boxFolders.getAt(index)!;
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 25.h : 4.h),
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: AppColors.surfaceColor,
                  ),
                  child: FormForButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoldersMainScreen(
                            index: index,
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Text(
                            folderItem.name,
                            style: AppTextStyles.displayMedium18_900.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            folderItem.looksItems.length.toString(),
                            style: AppTextStyles.bodyMedium16_400.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
