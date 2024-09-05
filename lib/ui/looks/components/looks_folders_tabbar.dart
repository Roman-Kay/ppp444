import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class LooksFoldersTabbar extends StatelessWidget {
  LooksFoldersTabbar({super.key});

  final List<FolderItem> listOfFoldersItems = [
    FolderItem(
      name: 'Holidays',
      lookstems: [],
    ),
    FolderItem(
      name: 'Weekends',
      lookstems: [],
    ),
    FolderItem(
      name: 'Everyday',
      lookstems: [],
    ),
    FolderItem(
      name: 'Job',
      lookstems: [],
    ),
    FolderItem(
      name: 'Active leisure',
      lookstems: [],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return listOfFoldersItems.isEmpty
        ? Column(
            children: [
              SizedBox(height: 60.h),
              Image.asset(
                'assets/images/folders_empty.png',
                width: 210.w,
              ),
              SizedBox(height: 15.h),
              Text(
                'You don\'t have folders',
                style: AppTextStyles.displayMedium18_900,
              ),
            ],
          )
        : ListView.builder(
            itemCount: listOfFoldersItems.length,
            itemBuilder: (context, index) {
              final FolderItem folderItem = listOfFoldersItems[index];
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
                    onPressed: () {},
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
                            folderItem.lookstems.length.toString(),
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
