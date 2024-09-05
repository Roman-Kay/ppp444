import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/ui/looks/folders/folders_main_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

// вынес сюда чтобы можно было ментяь на других экранах
final List<FolderItem> listOfFoldersItems = [
  FolderItem(
    name: 'Holidays',
    lookstems: [
      LookItem(
        name: 'Summer vibe',
        clothesItem: [
          ClothesItem(
            category: 'Accessories',
            imageName: 'hat',
            name: 'Summer hat',
          ),
          ClothesItem(
            category: 'Casual clothes',
            imageName: 'dress',
            name: 'Dress with flowers',
          ),
          ClothesItem(
            category: 'Shoes',
            imageName: 'shoes_1',
            name: 'Stylish sandals',
          ),
        ],
      ),
      LookItem(
        name: 'Evening walk',
        clothesItem: [
          ClothesItem(
            category: 'Casual clothes',
            imageName: 'shirt',
            name: 'Casual shirt',
          ),
          ClothesItem(
            category: 'Shoes',
            imageName: 'shoes_1',
            name: 'Stylish sandals',
          ),
          ClothesItem(
            category: 'Shoes',
            imageName: 'shoes_2',
            name: 'White sneakers',
          ),
        ],
      ),
      LookItem(
        name: 'Birthday party',
        clothesItem: [
          ClothesItem(
            category: 'Casual clothes',
            imageName: 'dress',
            name: 'Dress with flowers',
          ),
          ClothesItem(
            category: 'Casual clothes',
            imageName: 'shirt',
            name: 'Casual shirt',
          ),
          ClothesItem(
            category: 'Shoes',
            imageName: 'hat',
            name: 'Stylish sandals',
          ),
          ClothesItem(
            category: 'Shoes',
            imageName: 'shoes_2',
            name: 'White sneakers',
          ),
        ],
      ),
    ],
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

class LooksFoldersTabbar extends StatelessWidget {
  const LooksFoldersTabbar({super.key});

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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoldersMainScreen(folderItem: folderItem),
                      ),
                    ),
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
