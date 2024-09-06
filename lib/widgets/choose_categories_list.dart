import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/categories.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/form_for_button.dart';

// передается по проекту
String choosenCategory = '';

class ChooseCategoriesList extends StatefulWidget {
  final Function()? setState;
  const ChooseCategoriesList({super.key, required this.setState});

  @override
  State<ChooseCategoriesList> createState() => _ChooseCategoriesListState();
}

class _ChooseCategoriesListState extends State<ChooseCategoriesList> {
  @override
  void initState() {
    // при открытии нового экрана выбор будет пуст
    choosenCategory = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // высота элементов в ListView 26.h
      // 15.h с верху и снизу для удобного скролла
      height: 26.h + 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Categories.listOfCategoriesItems.length,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: index != 0 ? 5.w : 0,
              ),
              child: Container(
                height: 26.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: choosenCategory == Categories.listOfCategoriesItems[index].name
                      ? AppColors.primaryColor
                      : null,
                  border: Border.all(
                    width: 0.5,
                    color: AppColors.whiteColor,
                  ),
                ),
                child: FormForButton(
                  onPressed: () {
                    choosenCategory == Categories.listOfCategoriesItems[index].name
                        ? choosenCategory = ''
                        : choosenCategory = Categories.listOfCategoriesItems[index].name;
                    widget.setState!();
                  },
                  borderRadius: BorderRadius.circular(26.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: Text(
                      Categories.listOfCategoriesItems[index].name,
                      style: AppTextStyles.bodyMedium12,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
