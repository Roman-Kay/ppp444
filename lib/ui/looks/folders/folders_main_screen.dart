import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/folders/folder_new_look_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/widget_button.dart';

class FoldersMainScreen extends StatefulWidget {
  final FolderItem folderItem;
  const FoldersMainScreen({super.key, required this.folderItem});

  @override
  State<FoldersMainScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersMainScreen> {
  TextEditingController controller = TextEditingController();
  late List<LookItem> listOfLooksItems;
  @override
  void initState() {
    listOfLooksItems = widget.folderItem.lookstems;
    super.initState();
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                CustomAppBar(
                  text: 'Folders',
                  needArrow: true,
                  customPopUpMenu: CustomPopUpMenu(
                    textFirst: 'Edit the Folder',
                    svgNameFirst: 'edit',
                    onPressedFirst: () {},
                    textSecond: 'Add New Look',
                    svgNameSecond: 'add',
                    onPressedSecond: () async {
                      final List<LookItem>? response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoldersNewLookScreen(),
                        ),
                      );
                      if (response != null) {
                        setState(() {
                          listOfLooksItems.addAll(response);
                        });
                        editItemInList(
                          widget.folderItem,
                          FolderItem(
                            name: widget.folderItem.name,
                            lookstems: listOfLooksItems,
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  widget.folderItem.name,
                  style: AppTextStyles.displayLarge32,
                ),
                SizedBox(height: 5.h),
                listOfLooksItems.isEmpty
                    ? Column(
                        children: [
                          EmptyWidget(
                            topPading: 60.h,
                            text: 'Folder is empty',
                            imageName: 'folders_empty',
                          ),
                          SizedBox(height: 50.h),
                          Button(
                            onPressed: () async {
                              final response = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FoldersNewLookScreen(),
                                ),
                              );
                              if (response != null) {
                                setState(() {
                                  listOfLooksItems.addAll(response);
                                });
                                editItemInList(
                                  widget.folderItem,
                                  FolderItem(
                                    name: widget.folderItem.name,
                                    lookstems: listOfLooksItems,
                                  ),
                                );
                              }
                            },
                            text: 'Add Looks',
                          )
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: listOfLooksItems.length,
                          padding: EdgeInsets.only(bottom: 50.h),
                          itemBuilder: (context, index) {
                            final LookItem lookItem = listOfLooksItems[index];
                            return Padding(
                              padding: EdgeInsets.only(top: index == 0 ? 10.h : 15.h),
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
                                                      listOfLooksItems[index] = LookItem(
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
                                                  (valeu) {},
                                                );
                                              },
                                              textSecond: 'Delete from folder',
                                              svgNameSecond: 'delete',
                                              onPressedSecond: () {
                                                setState(() {
                                                  listOfLooksItems.removeAt(index);
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
