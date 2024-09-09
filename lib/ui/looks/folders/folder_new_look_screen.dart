import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_list_vew.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/search.dart';
import 'package:ppp444/widgets/widget_button.dart';

class FoldersNewLookScreen extends StatefulWidget {
  final int index;
  final FolderItem folderItem;
  const FoldersNewLookScreen({super.key, required this.index, required this.folderItem});

  @override
  State<FoldersNewLookScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersNewLookScreen> {
  TextEditingController controller = TextEditingController();

  List<LookItem> choossenLookItem = [];

  late List? listOfFilteredLooksItems;
  final TextEditingController searchController = TextEditingController();

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredLooksItems = boxLooks.values.toList().where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredLooksItems = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    searchItems();
    searchController.addListener(searchItems);
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    const CustomAppBar(text: 'Back', needArrow: true),
                    boxLooks.isEmpty
                        ? EmptyWidget(
                            topPading: 60.h,
                            imageName: 'looks_empty',
                            text: 'You don\'t have looks',
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                Search(searchController: searchController),
                                SizedBox(height: 5.h),
                                CustomListView(
                                  itemCount: listOfFilteredLooksItems == null
                                      ? boxLooks.length
                                      : listOfFilteredLooksItems!.length,
                                  itemBuilder: (context, index) {
                                    final LookItem lookItem =
                                        // listOfFilteredLooksItems == null
                                        //     ?
                                        boxLooks.getAt(index)!;
                                    //     :
                                    // listOfFilteredLooksItems![index];
                                    return CustomListViewElement(
                                      needEdit: false,
                                      index: index,
                                      isChoosen: choossenLookItem.any(
                                        (element) => element == lookItem,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (choossenLookItem
                                              .any((element) => element == lookItem)) {
                                            (choossenLookItem.remove(lookItem));
                                          } else {
                                            choossenLookItem.add(lookItem);
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: choossenLookItem.isEmpty ? 0 : 1,
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom >= 10 ? 10.h : 20.h,
                        ),
                        child: Button(
                          text: 'Confirm',
                          boxShadow: true,
                          onPressed: () {
                            List<LookItem> helpLooks = widget.folderItem.looksItems;
                            helpLooks.addAll(choossenLookItem);
                            boxFolders.putAt(
                              widget.index,
                              FolderItem(
                                name: widget.folderItem.name,
                                looksItems: helpLooks,
                              ),
                            );
                            Navigator.pop(
                              context,
                              choossenLookItem,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
