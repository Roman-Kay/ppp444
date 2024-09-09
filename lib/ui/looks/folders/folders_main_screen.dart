import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/folders/folder_new_look_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_alert_dialog.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_list_vew.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/custom_pop_up_menu.dart';
import 'package:ppp444/widgets/widget_button.dart';

class FoldersMainScreen extends StatefulWidget {
  final int index;
  const FoldersMainScreen({super.key, required this.index});

  @override
  State<FoldersMainScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersMainScreen> {
  TextEditingController controller = TextEditingController();
  late FolderItem folderItem;
  @override
  void initState() {
    folderItem = boxFolders.values.toList()[widget.index];
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
                    onPressedFirst: () {
                      showCustomDialog(
                        context,
                        'Change name Folder',
                        'Give a name to the folder',
                        () {
                          boxFolders.putAt(
                            widget.index,
                            FolderItem(
                              name: controller.text,
                              looksItems: folderItem.looksItems,
                            ),
                          );
                          setState(() {
                            folderItem = FolderItem(
                              name: controller.text,
                              looksItems: folderItem.looksItems,
                            );
                            controller.text;
                          });
                          controller.text = '';
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
                    textSecond: 'Add New Look',
                    svgNameSecond: 'add',
                    onPressedSecond: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoldersNewLookScreen(
                            index: widget.index,
                            folderItem: folderItem,
                          ),
                        ),
                      );
                      setState(() {
                        folderItem = boxFolders.values.toList()[widget.index];
                      });
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  folderItem.name,
                  style: AppTextStyles.displayLarge32,
                ),
                SizedBox(height: 5.h),
                folderItem.looksItems.isEmpty
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
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoldersNewLookScreen(
                                    index: widget.index,
                                    folderItem: folderItem,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                            text: 'Add Looks',
                          )
                        ],
                      )
                    : CustomListView(
                        itemCount: folderItem.looksItems.length,
                        itemBuilder: (context, index) {
                          final LookItem lookItem = folderItem.looksItems[index];
                          return boxLooks.values.toList().indexWhere(
                                        (element) => element == lookItem,
                                      ) ==
                                  -1
                              ? Container(
                                  width: 100.w,
                                  height: 100,
                                  color: AppColors.blackColor,
                                )
                              : CustomListViewElement(
                                  index: boxLooks.values.toList().indexWhere(
                                        (element) => element == lookItem,
                                      ),
                                  setState: () {
                                    setState(() {
                                      folderItem = boxFolders.getAt(widget.index)!;
                                    });
                                  },
                                );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
