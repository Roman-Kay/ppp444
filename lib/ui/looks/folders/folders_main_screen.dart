import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/looks/folders/folder_new_look_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/utils/text_styles.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_list_vew.dart';
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
    listOfLooksItems = widget.folderItem.looksItems;
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
                        // editItemNameFolder(
                        //   widget.folderItem,
                        //   FolderItem(
                        //     name: widget.folderItem.name,
                        //     looksItems: listOfLooksItems,
                        //   ),
                        // );
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
                                // editItemNameFolder(
                                //   widget.folderItem,
                                //   FolderItem(
                                //     name: widget.folderItem.name,
                                //     looksItems: listOfLooksItems,
                                //   ),
                                // );
                              }
                            },
                            text: 'Add Looks',
                          )
                        ],
                      )
                    : CustomListView(
                        listOfItems: listOfLooksItems,
                        itemBuilder: (context, index) {
                          final LookItem lookItem = listOfLooksItems[index];
                          return CustomListViewElement(
                            lookItem: lookItem,
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
