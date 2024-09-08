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
  const FoldersNewLookScreen({super.key});

  @override
  State<FoldersNewLookScreen> createState() => _FoldersMainScreenState();
}

class _FoldersMainScreenState extends State<FoldersNewLookScreen> {
  TextEditingController controller = TextEditingController();

  List<LookItem> choossenLookItem = [];

  late List listOfLooksItems;
  late List listOfFilteredLooksItems;
  final TextEditingController searchController = TextEditingController();

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredLooksItems = listOfLooksItems.where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredLooksItems = listOfLooksItems;
    }
    setState(() {});
  }

  @override
  void initState() {
    listOfLooksItems = boxLooks.values.toList();
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
                    listOfLooksItems.isEmpty
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
                                  itemCount: listOfFilteredLooksItems.length,
                                  itemBuilder: (context, index) {
                                    final LookItem lookItem = listOfFilteredLooksItems[index];
                                    return CustomListViewElement(
                                      lookItem: lookItem,
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
