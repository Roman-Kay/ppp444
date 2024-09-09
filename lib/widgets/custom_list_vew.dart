import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/form_for_button.dart';

class CustomListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const CustomListView({super.key, required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        padding: EdgeInsets.only(bottom: 50.h),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class CustomListViewElement extends StatefulWidget {
  final int index;
  final Function()? onPressed;
  final bool? isChoosen;
  // final bool? needEdit;
  final Function()? deleteFunction;
  final Function()? setState;

  const CustomListViewElement({
    super.key,
    required this.index,
    this.onPressed,
    this.isChoosen,
    this.setState,
    this.deleteFunction,
  });

  @override
  State<CustomListViewElement> createState() => _CustomListViewElementState();
}

class _CustomListViewElementState extends State<CustomListViewElement> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        clipBehavior: Clip.hardEdge,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 189.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: widget.isChoosen == true ? AppColors.primaryColor : AppColors.surfaceColor,
          ),
          child: FormForButton(
            onPressed: widget.onPressed,
            borderRadius: BorderRadius.circular(30.r),
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Text(
                        boxLooks.getAt(widget.index)!.name,
                        style: AppTextStyles.displayBold20,
                      ),
                      const Spacer(),
                      if (widget.deleteFunction != null)
                        CustomPopUpMenu(
                          textFirst: 'Edit',
                          svgNameFirst: 'edit',
                          onPressedFirst: () {
                            showCustomDialog(
                              context,
                              'Look Name',
                              'Change the look name',
                              () async {
                                await editItemLook(
                                  boxLooks.getAt(widget.index),
                                  LookItem(
                                    name: controller.text,
                                    clothesItem: boxLooks.getAt(widget.index)!.clothesItem,
                                  ),
                                );
                                controller.text = '';
                                Navigator.pop(context);
                              },
                              () {
                                controller.text = '';
                                Navigator.pop(context);
                              },
                              controller,
                              (valeu) {
                                widget.setState!();
                              },
                            );
                          },
                          textSecond: 'Delete',
                          svgNameSecond: 'delete',
                          smallIcon: true,
                          onPressedSecond: widget.deleteFunction!,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  // высота элементов в ListView 120.h
                  // 15.h с верху и снизу для удобного скролла
                  height: 120.h + 30.h,
                  child: ListViewHorizontalElement(
                    clothesItem: boxLooks.getAt(widget.index)!.clothesItem,
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

class ListViewHorizontalElement extends StatelessWidget {
  final List<ClothesItem> clothesItem;
  const ListViewHorizontalElement({
    super.key,
    required this.clothesItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        itemCount: clothesItem.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: index != 0 ? 4 : 0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Image.memory(
                  base64Decode(clothesItem[index].imageBase64),
                  height: 120.h,
                  width: 120.h,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
